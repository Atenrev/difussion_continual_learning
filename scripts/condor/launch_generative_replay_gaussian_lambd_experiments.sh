condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 1 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 4 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 8 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 12 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 16 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 20 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 1 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 4 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 8 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 12 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 16 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_cl.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_symmetry_distill.json" --lambd 20 --generation_steps 10 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
