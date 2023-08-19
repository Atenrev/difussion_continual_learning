import os
import torch
import argparse
import numpy as np

from tqdm import tqdm
from typing import Any
from torchvision import transforms
from torchvision.models import resnet18, efficientnet_b0

# from src.models.simple_cnn import SimpleCNN
from src.common.utils import get_configuration
from src.datasets.fashion_mnist import create_dataloader
from src.pipelines.pipeline_ddim import DDIMPipeline
from src.common.visual import plot_bar
from src.models.simple_cnn import SimpleCNN


preprocess = transforms.Compose(
        [
            transforms.ToTensor(),
            transforms.Normalize([0.5], [0.5]),
            transforms.Resize((32, 32)),
            # Repeat channels to fit ResNet18
            transforms.Lambda(lambda x: x.repeat(3, 1, 1)),
        ]
    )


def __parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()

    parser.add_argument("--model_config_path", type=str,
                        default="configs/model/resnet.json")
    parser.add_argument("--weights_path", type=str,
                        default="results/cnn_fmnist/")
    parser.add_argument("--generator_path", type=str,
                        # default="results_fuji/smasipca/iid_results/fashion_mnist/diffusion/generation/ddim_medium_mse_teacher_2/42/best_model/")
                        default="results/fashion_mnist/diffusion/None/ddim_medium_mse/42/best_model/")

    parser.add_argument("--classifier_batch_size", type=int, default=256)
    parser.add_argument("--generator_batch_size", type=int, default=128)

    parser.add_argument("--n_samples", type=int, default=10000)
    parser.add_argument("--n_steps", type=int, default=5)
    parser.add_argument("--eta", type=float, default=0.0)
    parser.add_argument("--device", type=str, default="cuda")

    return parser.parse_args()


def main(args):
    device = args.device
    model_config = get_configuration(args.model_config_path)
    classifier = efficientnet_b0()
    print("Loading model from disk")
    classifier.load_state_dict(torch.load(os.path.join(args.weights_path, "efficient_net.pth")))
    classifier.to(device)
    classifier.eval()

    # evaluator_classifier = SimpleCNN(
    #     n_channels=model_config.model.channels,
    #     num_classes=model_config.model.n_classes
    # ).to(device)
    # evaluator_classifier = resnet18(num_classes=10).to(device)
    # evaluator_optimizer = torch.optim.Adam(
    #     evaluator_classifier.parameters(),
    #     lr=model_config.optimizer.lr,
    # )
    # criterion = torch.nn.CrossEntropyLoss()

    _, test_loader = create_dataloader(args.classifier_batch_size, preprocess)

    samples_per_class = {i: 0 for i in range(10)}
    for batch in test_loader:
        with torch.no_grad():
            batch_data = batch["pixel_values"].to(device)
            batch_labels = batch["label"].to(device)
            pred = classifier(batch_data)
            classes = torch.nn.functional.softmax(pred, dim=1)
            classes = torch.argmax(classes, dim=1)
            classes_np = classes.cpu().numpy()

            for c in classes_np:
                samples_per_class[c] += 1

    # Calculate entropy
    n_samples = sum(samples_per_class.values())
    probabilities = np.array(list(samples_per_class.values())) / n_samples
    entropy = -np.sum(probabilities * np.log(probabilities))
    print(f"Entropy: {entropy:.4f}")

    # Extract class names and sample counts
    class_names = list(samples_per_class.keys())
    sample_counts = list(samples_per_class.values())

    # Plot bar chart
    save_path = os.path.join(args.generator_path, f"mnist_samples_per_class_entropy_{entropy:.4f}.png")
    plot_bar(
        class_names,
        sample_counts,
        x_label="Classes",
        y_label="Number of samples",
        title="Number of samples for each class",
        save_path=save_path
    )

    generator_pipeline = DDIMPipeline.from_pretrained(args.generator_path)
    generator_pipeline.set_progress_bar_config(disable=True)
    generator_pipeline = generator_pipeline.to(args.device)

    # initializes dict with the 10 classes to 0
    samples_per_class = {i: 0 for i in range(10)}
    entropy = 0.0
    n_iterations = args.n_samples // args.generator_batch_size
    pbar = tqdm(range(n_iterations))
    for it in pbar:
        generated_samples = generator_pipeline(
            args.generator_batch_size,
            num_inference_steps=args.n_steps,
            eta=args.eta,
            output_type="torch_raw",
        )

        # Repeat channels to fit the model
        generated_samples = generated_samples.repeat(1, 3, 1, 1)

        with torch.no_grad():
            classes = classifier(generated_samples)

        # Compute entropy
        classes = torch.nn.functional.softmax(classes, dim=1)
        classes = torch.argmax(classes, dim=1)
        classes_np = classes.cpu().numpy()

        for c in classes_np:
            samples_per_class[c] += 1

    #     evaluator_optimizer.zero_grad()
    #     preds = evaluator_classifier(generated_samples)
    #     loss_evaluator = criterion(preds, classes)
    #     loss_evaluator.backward()
    #     evaluator_optimizer.step()
    #     pbar.set_description(
    #         f"Loss: {loss_evaluator.item():.4f}, Accuracy: {(preds.argmax(dim=1) == classes).float().mean().item():.4f}")

    #     if it % 50 == 0 and it > 0:
    #         print("Evaluating model")
    #         evaluator_classifier.eval()
    #         accuracy_list = []
    #         for batch in test_loader:
    #             with torch.no_grad():
    #                 batch_data = batch["pixel_values"].to(device)
    #                 batch_labels = batch["label"].to(device)
    #                 pred = evaluator_classifier(batch_data)
    #                 accuracy = (pred.argmax(dim=1) == batch_labels).float().mean()
    #                 accuracy_list.append(accuracy.item())
    #         print(f"Accuracy: {sum(accuracy_list) / len(accuracy_list)}")
    #         evaluator_classifier.train()

    # print("Evaluating model")
    # evaluator_classifier.eval()
    # accuracy_list = []
    # for batch in test_loader:
    #     with torch.no_grad():
    #         batch_data = batch["pixel_values"].to(device)
    #         batch_labels = batch["label"].to(device)
    #         pred = evaluator_classifier(batch_data)
    #         accuracy = (pred.argmax(dim=1) == batch_labels).float().mean()
    #         accuracy_list.append(accuracy.item())
    # print(f"Accuracy: {sum(accuracy_list) / len(accuracy_list)}")

    # Compute entropy
    n_samples = sum(samples_per_class.values())
    probabilities = np.array(list(samples_per_class.values())) / n_samples
    entropy = -np.sum(probabilities * np.log(probabilities))

    # Extract class names and sample counts
    class_names = list(samples_per_class.keys())
    sample_counts = list(samples_per_class.values())

    # Plot bar chart
    save_path = os.path.join(args.generator_path, f"mnist_samples_per_class_{args.n_steps}_entropy_{entropy:.4f}.png")
    plot_bar(
        class_names,
        sample_counts,
        x_label="Classes",
        y_label="Number of samples",
        title="Number of samples for each class",
        save_path=save_path
    )


if __name__ == "__main__":
    args = __parse_args()
    main(args)
