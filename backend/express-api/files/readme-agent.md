# Agent Reference — Express REST API

## Overview

Node.js REST API built with Express. Includes JWT authentication scaffolding, CORS middleware, and a modular route structure. Runs as a standalone HTTP server.

## Tech Stack

- **Express 4** — HTTP framework with middleware chain
- **jsonwebtoken** — JWT token signing and verification
- **cors** — Cross-origin resource sharing middleware
- **dotenv** — Environment variable loading from `.env`

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json              — Dependencies and scripts (start, dev)
src/server.js             — Entry point: Express app setup, middleware, routes, listen
src/routes/auth.js        — Authentication routes (login, register stubs)
src/routes/users.js       — User CRUD route stubs
src/middleware/auth.js     — JWT verification middleware
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup
run.sh                    — Start development server (with --watch)
stop.sh                   — Stop the running server
Dockerfile                — Production container (node:20-alpine)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PORT` | No | `3000` | Port the Express server listens on |
| `JWT_SECRET` | Yes | `change-me-to-a-random-secret` | Secret key for signing JWT tokens. **Must be changed in production.** |
| `CORS_ORIGIN` | No | `http://localhost:5173` | Allowed origin for CORS requests |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env` if `.env` doesn't exist | `bash init.sh` |
| `run.sh` | Start the Express server with Node's `--watch` flag for auto-restart on file changes | `bash run.sh` |
| `stop.sh` | Stop the running server by killing the process on the configured PORT | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The server starts at `http://localhost:3000`. The `--watch` flag restarts the server automatically when files change.

For production mode:

```bash
npm start
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t express-api .
docker run -d -p 3000:3000 \
  -e JWT_SECRET=your-production-secret \
  -e CORS_ORIGIN=https://your-frontend.com \
  --name express-api express-api
```

Or use an env file:

```bash
docker run -d -p 3000:3000 --env-file .env --name express-api express-api
```

The Dockerfile installs only production dependencies (`--omit=dev`) and runs `node src/server.js` directly.

## Health Check

```bash
curl -s http://localhost:3000/health
```

Expected response: `{"status":"ok"}`

## API Endpoints

| Method | Path | Auth | Description |
|--------|------|------|-------------|
| GET | `/health` | No | Health check |
| POST | `/api/auth/login` | No | Login (stub) |
| POST | `/api/auth/register` | No | Register (stub) |
| GET | `/api/users` | JWT | List users (stub) |

## Customization

- **Add routes:** Create new files in `src/routes/` and mount them in `src/server.js` with `app.use('/api/<path>', require('./routes/<file>'))`
- **Add middleware:** Create files in `src/middleware/` and apply them per-route or globally
- **Add database:** Install a database client (pg, mongoose, prisma) and add `DATABASE_URL` to `.env`
- **JWT configuration:** Update `JWT_SECRET` in `.env` and configure token expiry in `src/middleware/auth.js`
