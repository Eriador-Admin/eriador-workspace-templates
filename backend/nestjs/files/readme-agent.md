# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item        | Detail                          |
| ----------- | ------------------------------- |
| Framework   | NestJS 10.x                     |
| Language    | TypeScript 5.x                  |
| Runtime     | Node.js 20+                     |
| Port        | {{PORT}} (default 3000)         |
| Entry point | `src/main.ts`                   |
| Build       | `dist/main.js`                  |

## Project Structure

```
├── src/
│   ├── main.ts                    # Bootstrap & server start
│   ├── app.module.ts              # Root module
│   ├── app.controller.ts          # Health check controller
│   ├── app.service.ts             # App service
│   └── items/
│       ├── items.module.ts        # Items feature module
│       ├── items.controller.ts    # CRUD controller
│       ├── items.service.ts       # Business logic
│       └── dto/
│           ├── create-item.dto.ts # Create DTO
│           └── update-item.dto.ts # Update DTO
├── nest-cli.json                  # Nest CLI config
├── tsconfig.json                  # TypeScript config
├── tsconfig.build.json            # Build-specific TS config
├── package.json
├── init.sh                        # Setup script
├── run.sh                         # Start dev server
├── stop.sh                        # Stop dev server
├── Dockerfile                     # Container build
├── .env.example                   # Environment template
└── .gitignore
```

## Scripts

| Script    | Purpose                                          |
| --------- | ------------------------------------------------ |
| `init.sh` | Install dependencies, copy `.env`, build project |
| `run.sh`  | Start dev server with hot reload (`--watch`)     |
| `stop.sh` | Kill the process listening on the configured port |

## API Endpoints

| Method | Path          | Description       |
| ------ | ------------- | ----------------- |
| GET    | `/health`     | Health check      |
| GET    | `/items`      | List all items    |
| POST   | `/items`      | Create an item    |
| GET    | `/items/:id`  | Get item by ID    |
| PUT    | `/items/:id`  | Update item by ID |
| DELETE | `/items/:id`  | Delete item by ID |

## Environment Variables

| Variable      | Default                 | Description            |
| ------------- | ----------------------- | ---------------------- |
| `PORT`        | `3000`                  | Server port            |
| `CORS_ORIGIN` | `http://localhost:3000` | CORS allowed origin    |

## Common Commands

```bash
# Development with hot reload
npm run start:dev

# Debug mode
npm run start:debug

# Production build
npm run build
npm run start:prod

# Run tests
npm test

# Run tests with coverage
npm run test:cov

# Lint
npm run lint
```

## Docker

```bash
docker build -t {{APP_NAME}} .
docker run -p 3000:3000 {{APP_NAME}}
```
