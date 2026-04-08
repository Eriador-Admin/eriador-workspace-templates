import os
from dotenv import load_dotenv

load_dotenv()

from fastapi import FastAPI
from pydantic import BaseModel
from src.ingest import ingest_documents
from src.chain import query

app = FastAPI(title="{{PROJECT_NAME}}")


class QueryRequest(BaseModel):
    question: str


@app.post("/ingest")
def ingest():
    count = ingest_documents()
    return {"status": "ok", "chunks_ingested": count}


@app.post("/query")
def ask(req: QueryRequest):
    result = query(req.question)
    return result


@app.get("/health")
def health():
    return {"status": "ok"}
