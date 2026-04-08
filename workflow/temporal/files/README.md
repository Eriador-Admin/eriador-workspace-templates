# {{PROJECT_NAME}}

[Temporal](https://temporal.io/) durable workflow orchestration with TypeScript workers and an Express API to trigger workflows.

## Getting Started

```bash
bash init.sh    # install deps + start Temporal server
bash run.sh     # start worker + API
bash stop.sh    # stop everything
```

## Services

| Service | URL | Description |
|---------|-----|-------------|
| API | `http://localhost:3000` | Trigger and query workflows |
| Temporal UI | `http://localhost:8233` | Workflow execution dashboard |

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/workflow/order` | Start an order processing workflow |
| GET | `/workflow/:id` | Get workflow status |
| GET | `/health` | Health check |

## Project Structure

```
src/
  api.ts           # Express API to trigger workflows
  worker.ts        # Temporal worker process
  client.ts        # Temporal client setup
  workflows.ts     # Workflow definitions
  activities.ts    # Activity implementations
docker-compose.yml # Temporal server + dependencies
```

## Concepts

- **Workflows**: Durable functions that survive failures and restarts
- **Activities**: Side-effectful operations (HTTP calls, DB writes, etc.)
- **Workers**: Processes that execute workflows and activities
- **Task Queue**: Named queue connecting workflow starters to workers

## Requirements

- Node.js 18+
- Docker
