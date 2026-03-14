# Agent Reference — Go Fiber API

## Overview

Go web server built with the Fiber framework. Includes CORS middleware, request logging, and a modular handler structure. Compiles to a single static binary with no runtime dependencies.

## Tech Stack

- **Go 1.22+** — Compiled language with built-in concurrency
- **Fiber v2** — Express-inspired web framework for Go (built on fasthttp)
- **godotenv** — Environment variable loading from `.env`

## Prerequisites

- Go >= 1.22

## Project Structure

```
main.go                   — Entry point: Fiber app setup, middleware, routes, listen
handlers/items.go         — Item CRUD handler functions
go.mod                    — Go module definition and dependencies
.env.example              — Environment variable defaults
init.sh                   — Download dependencies and setup .env
run.sh                    — Start the server via go run
stop.sh                   — Stop the running server
Dockerfile                — Multi-stage production build (static binary + alpine)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PORT` | No | `3000` | Port the Fiber server listens on |
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Run `go mod tidy` to download dependencies, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Start the server with `go run main.go` | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:3000`.

For a compiled binary:

```bash
go build -o server .
./server
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t go-fiber-api .
docker run -d -p 3000:3000 \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name go-fiber-api go-fiber-api
```

Or use an env file:

```bash
docker run -d -p 3000:3000 --env-file .env --name go-fiber-api go-fiber-api
```

The Dockerfile uses a multi-stage build:
1. **Stage 1 (golang:1.22-alpine):** Downloads dependencies and compiles a static binary with `CGO_ENABLED=0`.
2. **Stage 2 (alpine:3.19):** Copies only the compiled binary. Final image is ~15 MB.

## Health Check

```bash
curl -s http://localhost:3000/health
```

Expected response: `{"status":"ok"}`

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/health` | Health check |
| GET | `/api/items` | List all items |
| POST | `/api/items` | Create a new item |

## Customization

- **Add routes:** Create new handler files in `handlers/` and register them in `main.go` on the `api` group
- **Add middleware:** Fiber has built-in middleware (limiter, compress, cache, etc.) — add them in `main.go` with `app.Use()`
- **Rename module:** Update the module path in `go.mod` and all import statements
- **Add database:** Install a driver (e.g., `pgx` for PostgreSQL) and add `DATABASE_URL` to `.env`
