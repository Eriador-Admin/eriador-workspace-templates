import os
from dotenv import load_dotenv

load_dotenv()

from fastapi import FastAPI
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from src.chat import chat, chat_stream

app = FastAPI(title="{{PROJECT_NAME}}")


class ChatRequest(BaseModel):
    message: str
    system_prompt: str = "You are a helpful assistant."


@app.post("/chat")
def chat_endpoint(req: ChatRequest):
    response = chat(req.message, req.system_prompt)
    return {"response": response}


@app.post("/chat/stream")
def chat_stream_endpoint(req: ChatRequest):
    return StreamingResponse(
        chat_stream(req.message, req.system_prompt),
        media_type="text/plain",
    )


@app.get("/health")
def health():
    return {"status": "ok"}
