FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install all required dependencies for llama.cpp and Python
RUN apt-get update && apt-get install -y \
    git wget curl build-essential cmake python3 python3-pip python-is-python3 \
    clang libopenblas-dev libomp-dev pkg-config

# Clone llama.cpp
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp

# Build llama.cpp
WORKDIR /app/llama.cpp
RUN mkdir build
WORKDIR /app/llama.cpp/build
RUN cmake ..
RUN cmake --build . --config Release

# Back to base dir
WORKDIR /app

# Copy handler code
COPY . .

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Environment variable pointing to the llama binary
ENV LLAMA_BIN=/app/llama.cpp/build/main

# Start the RunPod handler
CMD ["python", "runpod_handler.py"]
