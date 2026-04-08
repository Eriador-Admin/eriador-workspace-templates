# {{PROJECT_NAME}}

A monorepo managed with [Nx](https://nx.dev/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # build all projects
bash stop.sh    # (no-op for build tasks)
```

## Project Structure

```
apps/
  my-app/         # Application project
libs/
  shared/         # Shared library
nx.json           # Nx configuration
```

## Commands

```bash
npx nx build my-app          # Build a specific project
npx nx run-many -t build     # Build all projects
npx nx graph                 # View dependency graph
npx nx affected -t build     # Build only affected projects
```

## Requirements

- Node.js 18+
