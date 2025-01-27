import json
import argparse
import torch
import numpy as np

from tqdm import tqdm
from torch.optim import Adam
from diffusers import UNet2DModel, DDIMScheduler

import sys
from pathlib import Path
# This script should be run from the root of the project
sys.path.append(str(Path(__file__).parent.parent))

from src.common.utils import get_configuration
from src.common.diffusion_utils import wrap_in_pipeline
from src.pipelines.pipeline_ddim import DDIMPipeline


def __parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    # 28 for vae, 32 for unet
    parser.add_argument("--image_size", type=int, default=32)
    parser.add_argument("--channels", type=int, default=1)

    parser.add_argument("--model_config_path", type=str,
                        default="configs/model/ddim_medium.json")

    parser.add_argument("--teacher_generation_steps", type=int, default=2)

    parser.add_argument("--batch_size", type=int, default=128)

    parser.add_argument("--output_path", type=str, default="results/speed_test.json")
    parser.add_argument("--seed", type=int, default=42)
    return parser.parse_args()


def test_base_training_speed(args, model, optimizer, device, batch_size=128):
    print ("Testing base training speed...")

    time_list = []
    for _ in tqdm(range(1000)):
        start = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        noisy_samples = torch.randn(batch_size, 1, args.image_size, args.image_size).to(device)
        noise = torch.randn(batch_size, 1, args.image_size, args.image_size).to(device)
        timesteps = torch.randint(0, 1000, (batch_size,)).to(device)

        start.record()
        optimizer.zero_grad()
        output = model(noisy_samples, timesteps, return_dict=False)[0]
        loss = torch.mean((output - noise) ** 2)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)
        optimizer.step()
        end.record()

        torch.cuda.synchronize()
        time_list.append(start.elapsed_time(end))

    print(f"Average time: {np.mean(time_list)}+-{np.std(time_list)}")
    return np.mean(time_list), np.std(time_list)


def test_gaussian_distillation_speed(args, model, teacher, optimizer, device):
    print ("Testing gaussian distillation speed...")

    time_list = []
    for _ in tqdm(range(1000)):
        start = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)

        start.record()
        optimizer.zero_grad()
        noise = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        timestep = torch.randint(0, 1000, (args.batch_size,)).to(device)
        output = model(noise, timestep, return_dict=False)[0]
        with torch.no_grad():
            teacher_output = teacher(noise, timestep, return_dict=False)[0]
        loss = torch.mean((output - teacher_output) ** 2)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)
        optimizer.step()
        end.record()

        torch.cuda.synchronize()
        time_list.append(start.elapsed_time(end))

    print(f"Average time: {np.mean(time_list)}+-{np.std(time_list)}")
    return np.mean(time_list), np.std(time_list)


def test_generation_distillation_speed(args, model, teacher, scheduler, optimizer, device):
    print ("Testing generation distillation speed...")

    time_list = []
    for _ in tqdm(range(1000)):
        start = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        noisy_samples = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        noise = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        timesteps = torch.randint(0, 1000, (args.batch_size,)).to(device)

        start.record()
        noise_replay = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        timesteps_replay = torch.randint(0, 1000, (args.batch_size,)).to(device)
        generated_images = teacher.generate(args.batch_size)
        noisy_images = scheduler.add_noise(generated_images, noise_replay, timesteps_replay)

        with torch.no_grad():
            teacher_output = teacher(noisy_images, timesteps_replay, return_dict=False)[0]

        all_samples = torch.cat([noisy_samples, noisy_images], dim=0)
        all_noises = torch.cat([noise, teacher_output], dim=0)
        all_timesteps = torch.cat([timesteps, timesteps_replay], dim=0)

        optimizer.zero_grad()
        output = model(all_samples, all_timesteps, return_dict=False)[0]
        loss = torch.mean((output - all_noises) ** 2)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)
        optimizer.step()
        end.record()

        torch.cuda.synchronize()
        time_list.append(start.elapsed_time(end))

    print(f"Average time: {np.mean(time_list)}+-{np.std(time_list)}")
    return np.mean(time_list), np.std(time_list)


def test_generation_no_distillation_speed(args, model, teacher, scheduler, optimizer, device):
    print ("Testing generation no distillation speed...")

    time_list = []
    for _ in tqdm(range(1000)):
        start = torch.cuda.Event(enable_timing=True)
        end = torch.cuda.Event(enable_timing=True)
        noisy_samples = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        noise = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        timesteps = torch.randint(0, 1000, (args.batch_size,)).to(device)

        start.record()
        noise_replay = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
        timesteps_replay = torch.randint(0, 1000, (args.batch_size,)).to(device)
        generated_images = teacher.generate(args.batch_size)
        noisy_samples_replay = scheduler.add_noise(generated_images, noise_replay, timesteps_replay)

        all_samples = torch.cat([noisy_samples, noisy_samples_replay], dim=0)
        all_timesteps = torch.cat([timesteps, timesteps_replay], dim=0)
        all_noises = torch.cat([noise, noise_replay], dim=0)

        optimizer.zero_grad()
        output = model(all_samples, all_timesteps, return_dict=False)[0]
        loss = torch.mean((output - all_noises) ** 2)
        loss.backward()
        torch.nn.utils.clip_grad_norm_(model.parameters(), 1.0)
        optimizer.step()
        end.record()

        torch.cuda.synchronize()
        time_list.append(start.elapsed_time(end))

    print(f"Average time: {np.mean(time_list)}+-{np.std(time_list)}")
    return np.mean(time_list), np.std(time_list)


def main(args):
    assert torch.cuda.is_available()
    device = "cuda"
    model_config = get_configuration(args.model_config_path)
    model = UNet2DModel(
            sample_size=model_config.model.input_size,
            in_channels=model_config.model.in_channels,
            out_channels=model_config.model.out_channels,
            layers_per_block=model_config.model.layers_per_block,
            block_out_channels=model_config.model.block_out_channels,
            norm_num_groups=model_config.model.norm_num_groups,
            down_block_types=model_config.model.down_block_types,
            up_block_types=model_config.model.up_block_types,
        )
    model = model.to(device)

    noise_scheduler = DDIMScheduler(
        num_train_timesteps=model_config.scheduler.train_timesteps)
    # Copy model
    teacher = UNet2DModel(
            sample_size=model_config.model.input_size,
            in_channels=model_config.model.in_channels,
            out_channels=model_config.model.out_channels,
            layers_per_block=model_config.model.layers_per_block,
            block_out_channels=model_config.model.block_out_channels,
            norm_num_groups=model_config.model.norm_num_groups,
            down_block_types=model_config.model.down_block_types,
            up_block_types=model_config.model.up_block_types,
        )
    teacher = teacher.to(device)
    teacher.eval()
    wrap_in_pipeline(teacher, noise_scheduler, DDIMPipeline,
                        args.teacher_generation_steps, 0.0, def_output_type="torch_raw")
    
    optimizer = Adam(model.parameters(), lr=model_config.optimizer.lr)

    results = {
        "GPU": torch.cuda.get_device_name(device),
    }

    # Warmup
    noise = torch.randn(args.batch_size, 1, args.image_size, args.image_size).to(device)
    timestep = torch.randint(0, 1000, (args.batch_size,)).to(device)
    model(noise, timestep, return_dict=False)[0]
    teacher(noise, timestep, return_dict=False)[0]

    mean, std = test_base_training_speed(args, model, optimizer, device, batch_size=args.batch_size)
    results["base_training"] = {
        "mean": mean,
        "std": std,
        "mean_it/s": 1 / (mean / 1000),
        "10k_ms": mean * 10000,
        "10k_s": mean * 10000 / 1000,
        "10k_m": mean * 10000 / 60000,
        "10k_h": mean * 10000 / 3600000,
        "10k_d": mean * 10000 / 86400000,
        "20k_ms": mean * 20000,
        "20k_s": mean * 20000 / 1000,
        "20k_m": mean * 20000 / 60000,
        "20k_h": mean * 20000 / 3600000,
        "20k_d": mean * 20000 / 86400000,
    }

    mean, std = test_base_training_speed(args, model, optimizer, device, batch_size=args.batch_size*2)
    results["base_training"] = {
        "mean": mean,
        "std": std,
        "mean_it/s": 1 / (mean / 1000),
        "10k_ms": mean * 10000,
        "10k_s": mean * 10000 / 1000,
        "10k_m": mean * 10000 / 60000,
        "10k_h": mean * 10000 / 3600000,
        "10k_d": mean * 10000 / 86400000,
        "20k_ms": mean * 20000,
        "20k_s": mean * 20000 / 1000,
        "20k_m": mean * 20000 / 60000,
        "20k_h": mean * 20000 / 3600000,
        "20k_d": mean * 20000 / 86400000,
    }

    # mean, std = test_gaussian_distillation_speed(args, model, teacher, optimizer, device)
    # results["gaussian_distillation"] = {
    #     "mean": mean,
    #     "std": std,
    #     "mean_it/s": 1 / (mean / 1000),
    #     "10k_ms": mean * 10000,
    #     "10k_s": mean * 10000 / 1000,
    #     "10k_m": mean * 10000 / 60000,
    #     "10k_h": mean * 10000 / 3600000,
    #     "10k_d": mean * 10000 / 86400000,
    #     "20k_ms": mean * 20000,
    #     "20k_s": mean * 20000 / 1000,
    #     "20k_m": mean * 20000 / 60000,
    #     "20k_h": mean * 20000 / 3600000,
    #     "20k_d": mean * 20000 / 86400000,
    # }

    mean, std = test_generation_distillation_speed(args, model, teacher, noise_scheduler, optimizer, device)
    results["generation_distillation"] = {
        "mean": mean,
        "std": std,
        "mean_it/s": 1 / (mean / 1000),
        "10k_ms": mean * 10000,
        "10k_s": mean * 10000 / 1000,
        "10k_m": mean * 10000 / 60000,
        "10k_h": mean * 10000 / 3600000,
        "10k_d": mean * 10000 / 86400000,
        "20k_ms": mean * 20000,
        "20k_s": mean * 20000 / 1000,
        "20k_m": mean * 20000 / 60000,
        "20k_h": mean * 20000 / 3600000,
        "20k_d": mean * 20000 / 86400000,
    }

    mean, std = test_generation_no_distillation_speed(args, model, teacher, noise_scheduler, optimizer, device)
    results["generation_no_distillation"] = {
        "mean": mean,
        "std": std,
        "mean_it/s": 1 / (mean / 1000),
        "10k_ms": mean * 10000,
        "10k_s": mean * 10000 / 1000,
        "10k_m": mean * 10000 / 60000,
        "10k_h": mean * 10000 / 3600000,
        "10k_d": mean * 10000 / 86400000,
        "20k_ms": mean * 20000,
        "20k_s": mean * 20000 / 1000,
        "20k_m": mean * 20000 / 60000,
        "20k_h": mean * 20000 / 3600000,
        "20k_d": mean * 20000 / 86400000,
    }

    with open(args.output_path, "w") as f:
        json.dump(results, f, indent=4)


if __name__ == "__main__":
    args = __parse_args()
    main(args)
