#!/bin/bash
set -ex
seq_length=6912
share_length=3840
unshare_length=0
python export_onnx.py --model_path /workspace/models/Qwen-7B-Chat/ --device cpu --share_length $share_length --unshare_length $unshare_length --seq_length $seq_length --num_thread 16 --max_pos_len $seq_length
./compile.sh --mode int4 --name qwen-7b --share_length $share_length --addr_mode io_alone --unshare_length $unshare_length


share_length=6400
unshare_length=512
python export_onnx.py --model_path /workspace/models/Qwen-7B-Chat/ --device cpu --share_length $share_length --unshare_length $unshare_length --seq_length $seq_length --num_thread 16 --max_pos_len $seq_length
./compile.sh --mode int4 --name qwen-7b --share_length $share_length --addr_mode io_alone --unshare_length $unshare_length