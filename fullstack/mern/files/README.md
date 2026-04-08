# {{PROJECT_NAME}}

A full-stack MERN (MongoDB, Express, React, Node.js) application.

## Getting Started

```bash
bash init.sh    # install deps + start MongoDB
bash run.sh     # start backend (5000) + frontend (5173) concurrently
bash stop.sh    # stop everything
```

## Project Structure

```
backend/
  src/
    app.ts          # Express app setup
    server.ts       # Entry point
    models/
      Item.ts       # Mongoose model
    routes/
      items.ts      # CRUD routes
frontend/
  src/
    App.tsx         # React app with item CRUD
    main.tsx        # Entry point
docker-compose.yml  # MongoDB container
```

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/api/items` | List all items |
| POST | `/api/items` | Create an item |
| PUT | `/api/items/:id` | Update an item |
| DELETE | `/api/items/:id` | Delete an item |

## Requirements

- Node.js 18+
- Docker (for MongoDB)
