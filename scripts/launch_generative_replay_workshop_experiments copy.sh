condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 1.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 2.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 3.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 4.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 5.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 6.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 7.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_full_gen_distill.json" --generation_steps 10 --lambd 8.0 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 1 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 4 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 8 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 12 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 16 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 20 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 24 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_gaussian_distill.json" --lambd 28 --generation_steps 10 --seed -1 --output_dir results_fuji/smasipca/generative_replay_fixed/ --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_no_distill_preliminary_2.json" --generation_steps 10 --seed -1 --output_dir "results_fuji/smasipca/generative_replay_fixed/" --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python generative_replay.py --generator_strategy_config_path "configs/strategy/diffusion_no_distill_preliminary_10.json" --generation_steps 10 --seed -1 --output_dir "results_fuji/smasipca/generative_replay_fixed/" --solver_strategy_config_path "configs/strategy/cnn_w_diffusion.json"'
