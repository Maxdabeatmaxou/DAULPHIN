import subprocess

MODEL_PATH = "/workspace/dolphin-llama3-8b.Q4_K_M.gguf"
LLAMA_BIN = "/app/llama.cpp/build/bin/main"

def generate(prompt, temperature=0.7, max_tokens=512):
    command = [
        LLAMA_BIN,
        "-m", MODEL_PATH,
        "-p", prompt,
        "--temp", str(temperature),
        "--n-predict", str(max_tokens)
    ]
    result = subprocess.run(command, capture_output=True, text=True)
    return result.stdout
