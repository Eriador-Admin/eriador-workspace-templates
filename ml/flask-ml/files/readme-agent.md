# Agent Reference — Flask ML Service

## Overview

Python ML inference service built with Flask. Includes a `/predict` endpoint for model inference, scikit-learn for machine learning, CORS middleware, and gunicorn for production serving. The `model.py` module provides a pluggable interface for training and prediction logic.

## Tech Stack

- **Flask 3** — Lightweight Python web framework
- **scikit-learn** — Machine learning library (classification, regression, clustering)
- **NumPy** — Numerical computing
- **Gunicorn** — Production-grade WSGI HTTP server
- **Flask-CORS** — Cross-origin resource sharing middleware
- **python-dotenv** — Environment variable loading from `.env`

## Prerequisites

- Python >= 3.10
- pip (included with Python)

## Project Structure

```
app.py                    — Flask app: routes (/health, /predict), CORS, entry point
model.py                  — ML model logic: predict() function, model loading/training
requirements.txt          — Python dependencies
data/README.md            — Placeholder for training data files
.env.example              — Environment variable defaults
init.sh                   — Create venv, install dependencies, setup .env
run.sh                    — Start Flask dev server
stop.sh                   — Stop the running server
Dockerfile                — Production container with gunicorn (python:3.12-slim)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `FLASK_DEBUG` | No | `false` | Enable Flask debug mode (`true`/`false`). Set to `true` during development for auto-reload and detailed error pages. **Never enable in production.** |
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests |
| `PORT` | No | `5000` | Port the Flask/gunicorn server listens on |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Create Python virtual environment, install dependencies from `requirements.txt`, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Activate venv (if present) and start Flask dev server via `python app.py` | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:5000`.

Test the prediction endpoint:

```bash
curl -X POST http://localhost:5000/predict \
  -H "Content-Type: application/json" \
  -d '{"features": [1.0, 2.0, 3.0]}'
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t flask-ml .
docker run -d -p 5000:5000 \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name flask-ml flask-ml
```

Or use an env file:

```bash
docker run -d -p 5000:5000 --env-file .env --name flask-ml flask-ml
```

The Dockerfile uses `python:3.12-slim` and runs gunicorn (production WSGI server) instead of Flask's built-in dev server. Gunicorn binds to `0.0.0.0:5000`.

To mount training data or model files:

```bash
docker run -d -p 5000:5000 \
  -v /path/to/data:/app/data \
  -v /path/to/model.pkl:/app/model.pkl \
  --name flask-ml flask-ml
```

## Health Check

```bash
curl -s http://localhost:5000/health
```

Expected response: `{"status":"ok"}`

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/health` | Health check |
| POST | `/predict` | Run model inference. Body: `{"features": [number, ...]}`. Returns: `{"prediction": ...}` |

## Customization

- **Replace the model:** Edit `model.py` to load a real trained model (pickle, joblib, ONNX, etc.) and implement the `predict()` function
- **Add training data:** Place CSV/JSON files in the `data/` directory and reference them in `model.py`
- **Add endpoints:** Define new routes in `app.py` for batch prediction, model info, etc.
- **Add database:** Install SQLAlchemy, add `DATABASE_URL` to `.env`, and create a database module for logging predictions
- **Switch to FastAPI:** If you need async support or auto-generated API docs, migrate the routes to FastAPI (same Python stack)
