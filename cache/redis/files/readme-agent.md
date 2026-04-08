# Agent Instructions — {{PROJECT_NAME}}

This is a Redis patterns project demonstrating common use cases.

## Tech Stack
- **Data Store**: Redis
- **App Server**: Express + TypeScript
- **Client**: ioredis

## Key Conventions
- Entry point: `src/app.ts`
- Redis client in `src/redis.ts`
- Pattern implementations in `src/patterns/`
- Redis runs via Docker on port 6379
