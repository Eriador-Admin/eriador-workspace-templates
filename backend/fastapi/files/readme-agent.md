# Agent Reference — FastAPI

## Overview

Python REST API built with FastAPI. Includes Pydantic schemas for request/response validation, CORS middleware, and a modular route structure. Provides auto-generated Swagger and ReDoc API documentation.

## Tech Stack

- **FastAPI** — Async Python web framework with automatic OpenAPI docs
- **Uvicorn** — ASGI server for running the application
- **Pydantic** — Data validation and serialization via type annotations
- **python-dotenv** — Environment variable loading from `.env`

## Prerequisites

- Python >= 3.10
- pip (included with Python)

## Project Structure

```
main.py                   — Entry point: FastAPI app setup, CORS, router mounting
app/__init__.py           — Package init
app/routes.py             — API route definitions
app/schemas.py            — Pydantic request/response models
requirements.txt          — Python dependencies
.env.example              — Environment variable defaults
init.sh                   — Create venv, install dependencies, setup .env
run.sh                    — Start uvicorn dev server with hot reload
stop.sh                   — Stop the running server
Dockerfile                — Production container (python:3.12-slim)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests |
| `PORT` | No | `8000` | Port the uvicorn server listens on |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Create Python virtual environment, install dependencies from `requirements.txt`, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Activate venv (if present) and start uvicorn with `--reload` for auto-restart on file changes | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:8000`. Interactive API docs are at:
- Swagger UI: `http://localhost:8000/docs`
- ReDoc: `http://localhost:8000/redoc`

## Docker Deployment

Build and run the production container:

```bash
docker build -t fastapi-app .
docker run -d -p 8000:8000 \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name fastapi-app fastapi-app
```

Or use an env file:

```bash
docker run -d -p 8000:8000 --env-file .env --name fastapi-app fastapi-app
```

The Dockerfile uses `python:3.12-slim` and runs uvicorn directly (no `--reload` in production).

## Health Check

```bash
curl -s http://localhost:8000/health
```

Expected response: `{"status":"ok"}`

## Customization

- **Add routes:** Define new endpoints in `app/routes.py` or create additional route modules and mount them in `main.py` with `app.include_router()`
- **Add schemas:** Define Pydantic models in `app/schemas.py` for request validation and response serialization
- **Add database:** Install SQLAlchemy or Tortoise ORM, add `DATABASE_URL` to `.env`, and create a `app/database.py` module
- **Add auth:** Install `python-jose` for JWT handling and create an auth dependency in a new `app/auth.py` module
