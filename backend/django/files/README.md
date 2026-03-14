# {{APP_NAME}}

A Django REST Framework API project.

## Getting Started

```bash
# Initialize the project (create venv, install deps, run migrations)
bash init.sh

# Start the development server
bash run.sh

# Stop the development server
bash stop.sh
```

The API will be available at `http://localhost:{{PORT}}`.

## API Endpoints

- `GET /api/health/` — Health check
- `GET /api/items/` — List items
- `POST /api/items/` — Create item
- `GET /api/items/:id/` — Get item
- `PUT /api/items/:id/` — Update item
- `DELETE /api/items/:id/` — Delete item

## Admin Panel

Visit `http://localhost:{{PORT}}/admin/` after creating a superuser:

```bash
source .venv/bin/activate
python manage.py createsuperuser
```

## Docker

```bash
docker build -t {{APP_NAME}} .
docker run -p 8000:8000 {{APP_NAME}}
```

## Configuration

Copy `.env.example` to `.env` and update values as needed. See `readme-agent.md` for the full environment variable reference.
