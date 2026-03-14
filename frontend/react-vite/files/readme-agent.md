# Agent Reference — React + Vite

## Overview

Single-page React application built with Vite, React Router for client-side routing, and Tailwind CSS for styling. Produces a static bundle suitable for any static file server or CDN.

## Tech Stack

- **React 18** — UI component library
- **Vite 5** — Build tool and dev server with HMR
- **React Router 6** — Client-side routing
- **Tailwind CSS 3** — Utility-first CSS framework
- **PostCSS / Autoprefixer** — CSS processing

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json          — Dependencies and scripts
vite.config.js        — Vite build configuration (plugins, port, proxy)
tailwind.config.js    — Tailwind CSS theme and content paths
postcss.config.js     — PostCSS plugins (Tailwind, Autoprefixer)
index.html            — HTML entry point
src/main.js           — Application entry point, mounts React root
src/App.js            — Root component with router setup
src/index.css         — Global styles and Tailwind directives
.env.example          — Environment variable defaults
init.sh               — Install dependencies and setup
run.sh                — Start development server
stop.sh               — Stop development server
Dockerfile            — Multi-stage production build (nginx)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `VITE_API_URL` | No | `http://localhost:3000` | Backend API base URL. Accessible in code via `import.meta.env.VITE_API_URL` |
| `VITE_APP_TITLE` | No | `My React App` | Application title for display purposes |
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

The dev server starts at `http://localhost:5173` (or the port set in `VITE_DEV_PORT`). Changes to source files trigger instant hot module replacement.

To build for production without Docker:

```bash
npm run build
```

Output goes to `dist/` — a static bundle ready to be served by any HTTP server.

## Docker Deployment

Build and run the production container:

```bash
docker build -t react-vite-app .
docker run -d -p 8080:80 --name react-vite-app react-vite-app
```

The Dockerfile uses a multi-stage build:
1. **Stage 1 (node:20-alpine):** Installs dependencies and runs `npm run build` to produce the `dist/` bundle.
2. **Stage 2 (nginx:alpine):** Copies the static bundle into nginx's default serve directory.

The container serves on port **80**. Map it to any host port.

To pass environment variables at build time (they are baked into the static bundle):

```bash
docker build --build-arg VITE_API_URL=https://api.example.com -t react-vite-app .
```

**Note:** Since this is a static SPA, environment variables must be set at **build time**, not runtime. For runtime configuration, use a `config.js` file served alongside the bundle or an nginx sub_filter approach.

## Health Check

The app is a static SPA — there is no health endpoint. Verify the container is serving by checking HTTP 200 on the root path:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/
```

## Customization

- **Add pages:** Create components in `src/` and add routes in `src/App.js`
- **Add API calls:** Use `import.meta.env.VITE_API_URL` as the base URL for fetch/axios calls
- **Configure proxy:** In `vite.config.js`, add a `server.proxy` entry to forward `/api` requests to a backend during development
- **Change styling:** Modify `tailwind.config.js` for theme changes and `src/index.css` for global styles
