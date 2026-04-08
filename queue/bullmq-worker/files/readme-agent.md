# Agent Instructions — {{PROJECT_NAME}}

This is a BullMQ job processing service.

## Tech Stack
- **Queue**: BullMQ
- **Broker**: Redis
- **Dashboard**: Bull Board (Express adapter)
- **Language**: TypeScript

## Key Conventions
- Queue setup: `src/queue.ts`
- Worker: `src/worker.ts` dispatches to job processors in `src/jobs/`
- Dashboard: `src/dashboard.ts` runs Bull Board UI
- Use `src/producer.ts` to enqueue test jobs
- Redis connection configured via REDIS_URL env var
