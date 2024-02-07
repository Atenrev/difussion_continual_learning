python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_2.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 42 --output_dir "results/continual_learning/teacher_steps_2" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_2.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 69 --output_dir "results/continual_learning/teacher_steps_2" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_2.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 1714 --output_dir "results/continual_learning/teacher_steps_2" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 42 --output_dir "results/continual_learning/teacher_steps_10" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 69 --output_dir "results/continual_learning/teacher_steps_10" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 1714 --output_dir "results/continual_learning/teacher_steps_10" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 42 --output_dir "results/continual_learning/teacher_steps_100" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 69 --output_dir "results/continual_learning/teacher_steps_100" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_no_distill_preliminary_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --seed 1714 --output_dir "results/continual_learning/teacher_steps_100" --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 42 --output_dir results/continual_learning/teacher_steps_2 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 69 --output_dir results/continual_learning/teacher_steps_2 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 1714 --output_dir results/continual_learning/teacher_steps_2 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 42 --output_dir results/continual_learning/teacher_steps_10 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 69 --output_dir results/continual_learning/teacher_steps_10 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_10.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 1714 --output_dir results/continual_learning/teacher_steps_10 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 42 --output_dir results/continual_learning/teacher_steps_100 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 69 --output_dir results/continual_learning/teacher_steps_100 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_full_gen_distill_100.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 0.75 --seed 1714 --output_dir results/continual_learning/teacher_steps_100 --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_gaussian_distill.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --lambd 8 --generation_steps 20 --seed -1 --output_dir results/continual_learning/ --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10
python train_cl.py --generator_strategy_config_path "configs/strategy/cifar/diffusion_lwf_distill.json" --generator_config_path "configs/model/ddim_medium_3ch.json" --generation_steps 20 --lambd 1.25 --seed -1 --output_dir results/continual_learning/ --solver_strategy_config_path "configs/strategy/cifar/cnn_w_diffusion.json" --solver_config_path "configs/model/cnn_3ch.json" --dataset split_cifar10