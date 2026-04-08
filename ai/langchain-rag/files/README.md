# {{PROJECT_NAME}}

A Retrieval-Augmented Generation (RAG) pipeline with LangChain and ChromaDB.

## Getting Started

```bash
bash init.sh    # create venv & install deps
bash run.sh     # start the API server
bash stop.sh    # stop the server
```

## How It Works

1. **Ingest**: Load documents from `data/` into ChromaDB vector store
2. **Query**: Send a question via the API
3. **Retrieve**: Find relevant document chunks via similarity search
4. **Generate**: LLM generates an answer grounded in retrieved context

## Project Structure

```
src/
  ingest.py         # Document ingestion pipeline
  chain.py          # RAG chain (retrieval + generation)
  server.py         # FastAPI server
data/               # Place documents here (.txt, .pdf, .md)
chroma_db/          # Vector store (auto-created)
```

## API

```bash
# Ingest documents
curl -X POST http://localhost:{{DEV_PORT}}/ingest

# Ask a question
curl -X POST http://localhost:{{DEV_PORT}}/query \
  -H "Content-Type: application/json" \
  -d '{"question": "What is this about?"}'
```

## Requirements

- Python 3.11+
- OpenAI API key
