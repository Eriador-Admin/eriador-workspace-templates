# Agent Reference — Angular

## Overview

Enterprise-grade Angular application using standalone components, Angular Router, and TypeScript. Built with Angular CLI and served via `ng serve` in development.

## Tech Stack

- **Angular 18** — Component-based UI framework with standalone components
- **TypeScript 5.4** — Strict type checking enabled
- **RxJS 7** — Reactive programming for async data
- **Angular Router** — Client-side routing

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json              — Dependencies and scripts
angular.json              — Angular CLI workspace configuration
tsconfig.json             — TypeScript base configuration
tsconfig.app.json         — App-specific TypeScript configuration
src/index.html            — HTML entry point
src/main.ts               — Angular bootstrap entry
src/styles.css            — Global styles
src/app/app.component.ts  — Root component with router-outlet
src/app/app.config.ts     — Application providers (router)
src/app/app.routes.ts     — Route definitions
src/app/home/home.component.ts — Home page component
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup .env
run.sh                    — Start Angular dev server
stop.sh                   — Stop Angular dev server
Dockerfile                — Multi-stage production build (nginx)
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `DEV_PORT` | No | `4200` | Angular dev server port |
| `VITE_API_URL` | No | `http://localhost:3000` | Backend API base URL (use Angular `environment.ts` for production) |

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Start the Angular dev server | `bash run.sh` |
| `stop.sh` | Stop the Angular dev server | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Dev server runs at [http://localhost:4200](http://localhost:4200).

## Docker Deployment

```bash
docker build -t angular-app .
docker run -p 80:80 angular-app
```

The Dockerfile uses a multi-stage build:
1. **Build stage:** `node:20-alpine` — installs deps, runs `ng build --configuration production`
2. **Serve stage:** `nginx:alpine` — serves static files from `dist/`

Production app available at port 80.

## Health Check

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:4200/
```

## Customization

- **Add components:** `npx ng generate component <name>` or create standalone components manually in `src/app/`
- **Add routes:** Update `src/app/app.routes.ts` with new route entries
- **Add services:** Create injectable services in `src/app/` for API calls using `HttpClient`
- **Environment config:** Use `src/environments/` files for build-time configuration
