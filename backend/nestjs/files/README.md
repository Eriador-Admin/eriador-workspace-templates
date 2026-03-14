# {{APP_NAME}}

A NestJS REST API built with TypeScript.

## Getting Started

```bash
# Initialize the project (install deps, build)
bash init.sh

# Start the development server with hot reload
bash run.sh

# Stop the development server
bash stop.sh
```

The API will be available at `http://localhost:{{PORT}}`.

## API Endpoints

- `GET /health` — Health check
- `GET /items` — List items
- `POST /items` — Create item
- `GET /items/:id` — Get item
- `PUT /items/:id` — Update item
- `DELETE /items/:id` — Delete item

## Docker

```bash
docker build -t {{APP_NAME}} .
docker run -p 3000:3000 {{APP_NAME}}
```

## Configuration

Copy `.env.example` to `.env` and update values as needed. See `readme-agent.md` for the full environment variable reference.
