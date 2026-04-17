import os
from langchain_openai import ChatOpenAI

def get_llm():
    # LM Studio exposes an OpenAI-compatible API. 
    # 'host.docker.internal' is used to reach the host machine from within a Docker container.
    base_url = os.getenv("LMSTUDIO_BASE_URL", "http://host.docker.internal:1234/v1")
    api_key = os.getenv("OPENAI_API_KEY", "lm-studio")
    model_name = os.getenv("LMSTUDIO_MODEL", "mistralai-mistral-nemo-instruct-2407-12b-mpoa-v1")

    return ChatOpenAI(
        api_key=api_key,
        base_url=base_url,
        model=model_name,
        temperature=0.0
    )
