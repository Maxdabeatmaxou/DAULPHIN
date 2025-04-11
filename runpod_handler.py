import runpod
from handler import generate

def handler(event):
    inputs = event["input"]
    prompt = inputs.get("prompt", "")
    temperature = inputs.get("temperature", 0.7)
    max_tokens = inputs.get("max_tokens", 512)

    output = generate(prompt, temperature, max_tokens)
    return {"output": output}

runpod.serverless.start({"handler": handler})
