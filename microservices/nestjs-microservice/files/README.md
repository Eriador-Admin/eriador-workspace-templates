# {{SERVICE_NAME}}

A NestJS microservice with HTTP API and TCP microservice transport.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the service
bash stop.sh    # stop the service
```

## Project Structure

```
src/
  main.ts               # Bootstrap (HTTP + TCP hybrid)
  app.module.ts          # Root module
  app.controller.ts      # HTTP endpoints
  app.service.ts         # Business logic
  items/
    items.module.ts      # Items feature module
    items.controller.ts  # Items message patterns (TCP)
    items.service.ts     # Items service
    dto/
      create-item.dto.ts
```

## Endpoints

- **HTTP**: `http://localhost:{{HTTP_PORT}}/` — REST API
- **TCP**: Port {{TCP_PORT}} — Microservice transport (message patterns)

## Requirements

- Node.js 18+
