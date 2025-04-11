FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install base dependencies
RUN apt-get update && apt-get install -y \
    git curl wget build-essential cmake python3 python3-pip python-is-python3 \
    clang libopenblas-dev libomp-dev pkg-config

# Clone specific stable version of llama.cpp
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp && \
    cd llama.cpp && git checkout b7e2862  # Version stable connue

# Build llama.cpp manually
WORKDIR /app/llama.cpp
RUN mkdir -p build
WORKDIR /app/llama.cpp/build
RUN cmake ..
RUN cmake --build . --config Release

# Return to working directory
WORKDIR /app

# Copy project files
COPY . .

# Install Python deps
RUN pip install --upgrade pip && pip install -r requirements.txt

# Define the llama binary path
ENV LLAMA_BIN=/app/llama.cpp/build/main

# Launch the RunPod handler
CMD ["python", "runpod_handler.py"]
