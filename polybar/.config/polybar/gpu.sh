#!/bin/bash

# Check if nvidia-smi is available (NVIDIA GPU)
if command -v nvidia-smi &> /dev/null; then
    gpu_util=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)
    echo "${gpu_util}%"
# Check if rocm-smi is available (AMD GPU)
elif command -v rocm-smi &> /dev/null; then
    gpu_util=$(rocm-smi --showuse | grep "GPU use" | awk '{print $3}' | tr -d '%')
    echo "${gpu_util}%"
# Check if intel_gpu_top is available (Intel GPU)
elif command -v intel_gpu_top &> /dev/null; then
    gpu_util=$(intel_gpu_top -J -s 1 | grep "GPU busy" | awk '{print $3}' | tr -d '%')
    echo "${gpu_util}%"
else
    echo "N/A"
fi 