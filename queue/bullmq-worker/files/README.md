# {{PROJECT_NAME}}

Background job processing with [BullMQ](https://docs.bullmq.io/) and Redis, plus a Bull Board dashboard.

## Getting Started

```bash
bash init.sh    # install deps and start Redis
bash run.sh     # start the worker + dashboard
bash stop.sh    # stop everything
```

Dashboard: http://localhost:{{DEV_PORT}}/admin/queues

## Project Structure

```
src/
  worker.ts         # Job processor / worker
  queue.ts          # Queue definition and helpers
  dashboard.ts      # Express + Bull Board UI
  jobs/
    email.ts        # Example email job processor
    report.ts       # Example report job processor
  producer.ts       # CLI to enqueue test jobs
docker-compose.yml  # Redis container
```

## Requirements

- Node.js 18+
- Docker (for Redis)
