# Agent Reference — Next.js App Router

## Overview

Next.js 14 application using the App Router with React Server Components and built-in API routes. Supports both server-side rendering and static generation. The API routes in `app/api/` make this a full-stack capable template.

## Tech Stack

- **Next.js 14** — React framework with App Router, SSR, and API routes
- **React 18** — UI component library with Server Components support
- **TypeScript** — Type-safe development

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)

## Project Structure

```
package.json              — Dependencies and scripts
next.config.js            — Next.js configuration (output mode, redirects, etc.)
tsconfig.json             — TypeScript configuration
app/layout.tsx            — Root layout component (wraps all pages)
app/page.tsx              — Home page (server component by default)
app/api/hello/route.ts    — Example API route (GET handler)
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup
run.sh                    — Start development server
stop.sh                   — Stop development server
Dockerfile                — Production build container
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `NEXT_PUBLIC_API_URL` | No | `http://localhost:3000` | Public API base URL. Accessible in both server and client code via `process.env.NEXT_PUBLIC_API_URL` |
| `PORT` | No | `3000` | Port for the Next.js server (dev and production) |

Variables prefixed with `NEXT_PUBLIC_` are exposed to the browser. Server-only variables (no prefix) are only available in API routes, server components, and middleware.

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env` if `.env` doesn't exist | `bash init.sh` |
| `run.sh` | Start the Next.js dev server with hot reload | `bash run.sh` |
| `stop.sh` | Stop the running dev server by killing the process on the configured port | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The dev server starts at `http://localhost:3000`. Pages in `app/` are hot-reloaded on save.

To build for production without Docker:

```bash
npm run build
npm start
```

## Docker Deployment

Build and run the production container:

```bash
docker build -t next-app .
docker run -d -p 3000:3000 --name next-app next-app
```

To pass runtime environment variables:

```bash
docker run -d -p 3000:3000 \
  -e NEXT_PUBLIC_API_URL=https://api.example.com \
  --name next-app next-app
```

**Note:** `NEXT_PUBLIC_` variables used in client components are baked in at build time. To change them, rebuild the image. Server-only variables can be set at runtime.

For standalone output (smaller image), add `output: 'standalone'` to `next.config.js` and update the Dockerfile to copy only the standalone directory.

## Health Check

```bash
curl -s http://localhost:3000/api/hello
```

Expected response: JSON object. The `/api/hello` route is the built-in health-check endpoint.

## Customization

- **Add pages:** Create `app/<route>/page.tsx` files — the file path becomes the URL
- **Add API routes:** Create `app/api/<route>/route.ts` with exported HTTP method handlers (`GET`, `POST`, etc.)
- **Add layouts:** Create `app/<route>/layout.tsx` for nested layouts
- **Server vs Client components:** Components are server components by default. Add `'use client'` directive at the top for client-side interactivity
- **Database:** Add Prisma or Drizzle and configure `DATABASE_URL` in `.env`
