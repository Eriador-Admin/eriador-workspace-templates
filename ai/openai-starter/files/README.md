# {{PROJECT_NAME}}

A starter application for the OpenAI API with chat completions and streaming support.

## Getting Started

```bash
bash init.sh    # create venv & install deps
bash run.sh     # start the API server
bash stop.sh    # stop the server
```

## Features

- Chat completions API endpoint
- Streaming response support
- Conversation history management
- System prompt configuration

## API

```bash
# Chat completion
curl -X POST http://localhost:{{DEV_PORT}}/chat \
  -H "Content-Type: application/json" \
  -d '{"message": "Hello!", "system_prompt": "You are a helpful assistant."}'

# Streaming chat
curl -X POST http://localhost:{{DEV_PORT}}/chat/stream \
  -H "Content-Type: application/json" \
  -d '{"message": "Tell me a story"}'
```

## Requirements

- Python 3.11+
- OpenAI API key
