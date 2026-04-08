# Agent Instructions — {{PROJECT_NAME}}

This is a RAG (Retrieval-Augmented Generation) pipeline.

## Tech Stack
- **Framework**: LangChain
- **Vector Store**: ChromaDB (local, persistent)
- **LLM**: OpenAI ({{LLM_MODEL}})
- **Embeddings**: OpenAI ({{EMBEDDING_MODEL}})
- **API**: FastAPI

## Key Conventions
- Ingestion logic in `src/ingest.py` — loads docs, splits, embeds, stores
- RAG chain in `src/chain.py` — retrieval QA chain
- API server in `src/server.py` — FastAPI with /ingest and /query endpoints
- Documents go in `data/` directory
- ChromaDB persists to `chroma_db/`

## File Patterns
- `src/ingest.py` → Document loading and vectorization
- `src/chain.py` → LangChain RAG chain
- `src/server.py` → API endpoints
- `data/` → Source documents
