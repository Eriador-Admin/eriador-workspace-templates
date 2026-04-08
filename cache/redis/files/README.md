# {{PROJECT_NAME}}

Common [Redis](https://redis.io/) patterns: caching, pub/sub, sessions, and rate limiting.

## Getting Started

```bash
bash init.sh    # install deps + start Redis
bash run.sh     # start the Express demo app
bash stop.sh    # stop everything
```

## Endpoints

| URL | Description |
|-----|-------------|
| `GET /cache-demo` | Cache-aside pattern demo |
| `GET /pubsub` | Pub/sub message page |
| `POST /pubsub` | Publish a message |
| `GET /rate-limited` | Rate-limited endpoint (10 req/min) |
| `GET /session` | Session counter demo |

## Project Structure

```
src/
  app.ts              # Express app with all demos
  redis.ts            # Redis client setup
  patterns/
    cache.ts          # Cache-aside pattern
    pubsub.ts         # Publish/subscribe
    rate-limiter.ts   # Sliding window rate limiter
docker-compose.yml    # Redis container
```

## Requirements

- Node.js 18+
- Docker
