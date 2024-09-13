FROM nvidia/cuda:12.2.0-cudnn8-runtime-ubuntu20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TRANSFORMERS_CACHE=/workspace/transformers_cache
ENV HF_HOME=/workspace/hf_home

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --no-cache-dir torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu122

RUN pip3 install --no-cache-dir text-generation-inference

EXPOSE 8000

ENTRYPOINT ["text-generation-launcher"]
CMD ["--model-id", "your_model_id", "--port", "8000"]

