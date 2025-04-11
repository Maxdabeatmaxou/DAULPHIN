FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git wget curl build-essential cmake python3 python3-pip python-is-python3

# Clone llama.cpp
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp

# Build llama.cpp proprement
WORKDIR /app/llama.cpp
RUN mkdir build
WORKDIR /app/llama.cpp/build
RUN cmake ..
RUN cmake --build . --config Release

# Back to root dir
WORKDIR /app

# Copy code
COPY . .

# Python deps
RUN pip install -r requirements.txt

# Path to binary
ENV LLAMA_BIN=/app/llama.cpp/build/main

# RunPod handler
CMD ["python", "runpod_handler.py"]
