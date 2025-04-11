FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
    git wget curl build-essential cmake python3 python3-pip python-is-python3

RUN git clone https://github.com/ggerganov/llama.cpp /app/llama.cpp && \
    cd /app/llama.cpp && \
    cmake -B build && cmake --build build --config Release

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

ENV LLAMA_BIN=/app/llama.cpp/build/bin/main

CMD ["python", "runpod_handler.py"]
