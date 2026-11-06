# Agent Reference — SvelteKit

## Overview

Full-stack web application built with SvelteKit. Features file-based routing, server-side rendering, and Vite-powered HMR. Includes a minimal two-page example with a layout component.

## Tech Stack

- **Svelte 5** — Reactive UI compiler
- **SvelteKit 3** — Full-stack framework with SSR, file-based routing
- **Vite 8** — Build tool and dev server

## Prerequisites

- Node.js >= 22.17
- npm

## Project Structure

```
package.json                    — Dependencies and scripts
vite.config.js                  — Vite + SvelteKit configuration (adapter and kit options go in `sveltekit({...})`)
src/app.html                    — HTML shell template
src/routes/+layout.svelte       — Root layout with navigation
src/routes/+page.svelte         — Home page
src/routes/about/+page.svelte   — About page
static/                         — Static assets
.env.example                    — Environment variable defaults
init.sh / run.sh / stop.sh     — Lifecycle scripts
Dockerfile                      — Production container
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `PUBLIC_API_URL` | No | `http://localhost:5000` | Public API base URL (accessible client-side) |
| `DEV_PORT` | No | `5173` | Dev server port |

## Running Locally

```bash
bash init.sh
bash run.sh
```

## Customization

- **Add pages:** Create `src/routes/<path>/+page.svelte` files
- **Add API routes:** Create `src/routes/api/<path>/+server.js` files
- **Add layout:** Create `+layout.svelte` in any route directory
- **Change adapter:** The template uses `@sveltejs/adapter-node` (the Dockerfile runs its `build/` output with `node build`). Swap it in `vite.config.js` for `adapter-auto`, `adapter-static`, etc. SvelteKit 3 no longer reads `svelte.config.js`.
