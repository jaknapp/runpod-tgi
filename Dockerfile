# Stage 1: Start from Hugging Face's pre-built TGI image to get TGI binaries
FROM ghcr.io/huggingface/text-generation-inference:latest as tgi-stage

# Stage 2: Use the RunPod base image for GPU support
FROM runpod/pytorch:2.4.0-py3.11-cuda12.4.1-devel-ubuntu22.04

# Copy TGI from the previous stage
COPY --from=tgi-stage /usr/local/bin /usr/local/bin

# Install any additional dependencies you need
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    curl \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Expose port 8000 for the TGI service
EXPOSE 8000

# Set the entry point to launch the TGI service
ENTRYPOINT ["text-generation-launcher"]

# Default command to specify the model ID and port
CMD ["--model-id", "your_model_id", "--port", "8000"]
