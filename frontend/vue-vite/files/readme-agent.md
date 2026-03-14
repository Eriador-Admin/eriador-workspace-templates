# Agent Reference — Vue 3 + Vite

## Overview

Single-page Vue 3 application built with Vite, using the Composition API, Vue Router for navigation, and Pinia for state management. Produces a static bundle suitable for any static file server or CDN.

## Tech Stack

- **Vue 3** — UI framework with Composition API
- **Vite 5** — Build tool and dev server with HMR
- **Vue Router 4** — Client-side routing
- **Pinia 2** — State management (Vue's official store)

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json              — Dependencies and scripts
vite.config.js            — Vite build configuration (Vue plugin, port, proxy)
index.html                — HTML entry point
src/main.js               — Application entry, mounts Vue app with router and Pinia
src/App.vue               — Root component with <router-view>
src/router/index.js       — Route definitions
src/views/Home.vue        — Home page component
src/views/About.vue       — About page component
src/stores/counter.js     — Example Pinia store
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup
run.sh                    — Start development server
stop.sh                   — Stop development server
Dockerfile                — Multi-stage production build (nginx)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `VITE_API_URL` | No | `http://localhost:3000` | Backend API base URL. Accessible in code via `import.meta.env.VITE_API_URL` |
| `VITE_DEV_PORT` | No | `5173` | Port for the Vite development server |

All `VITE_` prefixed variables are exposed to client-side code at build time. Do not put secrets in `VITE_` variables.

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env` if `.env` doesn't exist | `bash init.sh` |
| `run.sh` | Start the Vite dev server with HMR | `bash run.sh` |
| `stop.sh` | Stop the running dev server by killing the process on the dev port | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The dev server starts at `http://localhost:5173` (or the port set in `VITE_DEV_PORT`). Changes to `.vue` files trigger instant hot module replacement.

To build for production without Docker:

```bash
npm run build
```

Output goes to `dist/` — a static bundle ready to be served by any HTTP server.

## Docker Deployment

Build and run the production container:

```bash
docker build -t vue-vite-app .
docker run -d -p 8080:80 --name vue-vite-app vue-vite-app
```

The Dockerfile uses a multi-stage build:
1. **Stage 1 (node:20-alpine):** Installs dependencies and runs `npm run build` to produce the `dist/` bundle.
2. **Stage 2 (nginx:alpine):** Copies the static bundle into nginx's default serve directory.

The container serves on port **80**. Map it to any host port.

To pass environment variables at build time:

```bash
docker build --build-arg VITE_API_URL=https://api.example.com -t vue-vite-app .
```

**Note:** Since this is a static SPA, environment variables must be set at **build time**, not runtime.

## Health Check

The app is a static SPA — there is no health endpoint. Verify the container is serving:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/
```

## Customization

- **Add pages:** Create `.vue` components in `src/views/` and add routes in `src/router/index.js`
- **Add state:** Create new Pinia stores in `src/stores/` following the `counter.js` pattern
- **Add API calls:** Use `import.meta.env.VITE_API_URL` as the base URL for fetch/axios calls
- **Configure proxy:** In `vite.config.js`, add a `server.proxy` entry to forward `/api` requests to a backend during development
