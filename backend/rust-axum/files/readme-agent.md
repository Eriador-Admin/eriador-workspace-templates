# Agent Reference — Rust Axum

## Overview

Async Rust HTTP server built with Axum and the Tokio runtime. Includes CORS middleware via tower-http, shared application state, and item CRUD endpoints. Compiles to a single static binary.

## Tech Stack

- **Rust 1.75+** — Systems programming language with memory safety guarantees
- **Axum 0.7** — Ergonomic web framework built on top of hyper and tower
- **Tokio** — Async runtime for Rust
- **tower-http** — HTTP middleware (CORS)
- **Serde** — Serialization/deserialization
- **dotenvy** — Environment variable loading from `.env`

## Prerequisites

- Rust >= 1.75 (install via [rustup](https://rustup.rs/))
- Cargo (included with Rust)

## Project Structure

```
Cargo.toml                — Crate metadata and dependencies
src/main.rs               — Entry point: router setup, shared state, handlers, server bind
.env.example              — Environment variable defaults
init.sh                   — Compile project and setup .env
run.sh                    — Start the server via cargo run
stop.sh                   — Stop the running server
Dockerfile                — Multi-stage production build (rust build + debian-slim runtime)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PORT` | No | `3000` | Port the Axum server listens on |
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Run `cargo build` to compile the project and download dependencies, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Start the server with `cargo run` (compiles if needed, then runs) | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:3000`. First run includes compilation time.

For an optimized release build:

```bash
cargo build --release
./target/release/rust-axum-api
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t rust-axum-api .
docker run -d -p 3000:3000 \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name rust-axum-api rust-axum-api
```

Or use an env file:

```bash
docker run -d -p 3000:3000 --env-file .env --name rust-axum-api rust-axum-api
```

The Dockerfile uses a multi-stage build:
1. **Stage 1 (rust:1.77-slim):** Caches dependency compilation, then builds the release binary.
2. **Stage 2 (debian:bookworm-slim):** Copies only the compiled binary. Final image is ~80 MB.

**Note:** If you rename the crate in `Cargo.toml`, update the binary name in the Dockerfile's `COPY --from=build` and `CMD` lines.

## Health Check

```bash
curl -s http://localhost:3000/health
```

Expected response: `{"status":"ok"}`

## API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| GET | `/health` | Health check |
| GET | `/api/items` | List all items (in-memory) |
| POST | `/api/items` | Create a new item (`{"name": "..."}`) |

## Customization

- **Add routes:** Define new handler functions in `src/main.rs` and add `.route()` calls to the Router
- **Split into modules:** Create `src/handlers/`, `src/models/`, `src/routes/` modules as the codebase grows
- **Add database:** Add `sqlx` or `diesel` to `Cargo.toml` and configure `DATABASE_URL` in `.env`
- **Rename crate:** Update `name` in `Cargo.toml` and the binary name in the Dockerfile
