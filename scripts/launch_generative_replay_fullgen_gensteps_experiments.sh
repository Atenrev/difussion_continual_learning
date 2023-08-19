condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 2 --lambd 5.0 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 5 --lambd 5.0 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 5.0 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 20 --lambd 5.0 --seed 42 --wandb --output_dir results_fuji/smasipca/generative_replay_single/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
