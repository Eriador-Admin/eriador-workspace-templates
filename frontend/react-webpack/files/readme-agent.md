# Agent Reference — React + Webpack

## Overview

Single-page React application built with Webpack 5, Babel for JSX/ES6+ transpilation, React Router for client-side routing, and Tailwind CSS for styling.

## Tech Stack

- **React 18** — UI component library
- **Webpack 5** — Module bundler with dev server and HMR
- **Babel** — JSX and ES6+ transpilation
- **React Router 6** — Client-side routing
- **Tailwind CSS 3** — Utility-first CSS framework

## Prerequisites

- Node.js >= 18
- npm

## Project Structure

```
package.json              — Dependencies and scripts
webpack.config.js         — Webpack config (dev server, loaders, plugins)
babel.config.json         — Babel presets (env, react)
tailwind.config.js        — Tailwind content paths and theme
postcss.config.js         — PostCSS plugins
public/index.html         — HTML template
src/index.js              — Entry point, mounts React root
src/App.js                — Root component with router
src/index.css             — Tailwind directives
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup
run.sh                    — Start dev server
stop.sh                   — Stop dev server
Dockerfile                — Multi-stage production build
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `REACT_APP_API_URL` | No | `http://localhost:5000` | Backend API base URL |
| `DEV_PORT` | No | `3000` | Webpack dev server port |

Variables prefixed with `REACT_APP_` are injected at build time via `webpack.DefinePlugin`.

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` | `bash init.sh` |
| `run.sh` | Start the Webpack dev server with HMR | `bash run.sh` |
| `stop.sh` | Stop the dev server | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

Dev server at `http://localhost:3000` with hot module replacement.

## Docker Deployment

```bash
docker build -t react-webpack-app .
docker run -d -p 8080:80 --name react-webpack-app react-webpack-app
```

## Customization

- **Add pages:** Create components in `src/` and add routes in `src/App.js`
- **Change port:** Update `DEV_PORT` in `.env`
- **Add loaders:** Edit `webpack.config.js` to handle SASS, TypeScript, etc.
- **Proxy API:** Add `devServer.proxy` in `webpack.config.js`
