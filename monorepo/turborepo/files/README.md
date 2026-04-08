# {{PROJECT_NAME}}

A monorepo managed with [Turborepo](https://turbo.build/repo) and npm workspaces.

## Getting Started

```bash
bash init.sh    # install all dependencies
bash run.sh     # start all apps in dev mode
bash stop.sh    # stop all dev servers
```

## Project Structure

```
apps/
  web/            # Frontend web application
  api/            # Backend API server
packages/
  shared/         # Shared utilities and types
  tsconfig/       # Shared TypeScript configs
turbo.json        # Turborepo pipeline configuration
```

## Commands

```bash
npx turbo run build          # Build all packages
npx turbo run dev            # Dev mode for all apps
npx turbo run lint           # Lint all packages
npx turbo run build --filter=web  # Build only the web app
```

## Requirements

- Node.js 18+
