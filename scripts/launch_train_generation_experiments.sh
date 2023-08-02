condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_iid.py --distillation_type generation --save_every 1000 --num_epochs 20000 --teacher_generation_steps 2'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_iid.py --distillation_type partial_generation --save_every 1000 --num_epochs 20000 --teacher_generation_steps 2'
condor_send -c 'CUDA_VISIBLE_DEVICES=${CUDA_VISIBLE_DEVICES#CUDA} python train_iid.py --distillation_type no_distillation --save_every 1000 --num_epochs 20000 --teacher_generation_steps 2'