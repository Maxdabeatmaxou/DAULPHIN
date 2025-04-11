FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    git wget curl build-essential cmake python3 python3-pip python-is-python3

# Clone and build llama.cpp
WORKDIR /app
RUN git clone https://github.com/ggerganov/llama.cpp
WORKDIR /app/llama.cpp
RUN mkdir build && cd build && cmake .. && cmake --build . --config Release

# Back to base dir
WORKDIR /app

# Copy your code
COPY . .

# Install Python deps
RUN pip install -r requirements.txt

# ENV path to compiled binary
ENV LLAMA_BIN=/app/llama.cpp/build/main

# Run handler
CMD ["python", "runpod_handler.py"]
