# {{PROJECT_NAME}}

A headless commerce backend built on [Medusa.js](https://medusajs.com/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the server (port 9000)
bash stop.sh    # stop the server
```

## Project Structure

```
src/
  api/              # Custom API routes
    store/
      custom/route.ts
  subscribers/      # Event subscribers
    product-created.ts
  jobs/             # Scheduled jobs
    sync-prices.ts
medusa-config.ts    # Medusa configuration
```

## Endpoints

- `GET /store/products` — List products
- `GET /store/custom` — Custom route example
- Admin panel at `http://localhost:9000/app`

## Requirements

- Node.js 20+
- PostgreSQL 15+ (or use Docker)
- Redis (optional, for events)
