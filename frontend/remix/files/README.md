# {{PROJECT_NAME}}

A full-stack web app built with [React Router](https://reactrouter.com/) framework mode, the successor to Remix.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the dev server
bash stop.sh    # stop the dev server
```

Open http://localhost:{{DEV_PORT}} in your browser.

## Project Structure

```
app/
  root.tsx          # Root layout
  routes.ts         # Route config (maps URLs to route modules)
  routes/
    _index.tsx      # Homepage (/)
    about.tsx       # About page (/about)
react-router.config.ts  # Framework options (SSR on)
vite.config.ts      # Vite + React Router plugin
```

## Scripts

| Command             | Action                                        |
|:--------------------|:----------------------------------------------|
| `npm run dev`       | Start the dev server                          |
| `npm run build`     | Build client and server bundles to `build/`   |
| `npm start`         | Serve the production build                    |
| `npm run typecheck` | Generate route types and run `tsc`            |

## Requirements

- Node.js 22.22+
