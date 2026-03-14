# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item        | Detail                              |
| ----------- | ----------------------------------- |
| Framework   | Django 5.x + Django REST Framework  |
| Language    | Python 3.12+                        |
| Port        | {{PORT}} (default 8000)             |
| Entry point | `manage.py`                         |
| Settings    | `{{APP_NAME}}/settings.py`          |

## Project Structure

```
├── manage.py                  # Django CLI
├── requirements.txt           # Python dependencies
├── {{APP_NAME}}/
│   ├── __init__.py
│   ├── settings.py            # Project settings
│   ├── urls.py                # Root URL config
│   ├── wsgi.py                # WSGI entry
│   └── asgi.py                # ASGI entry
├── api/
│   ├── __init__.py
│   ├── models.py              # Database models
│   ├── serializers.py         # DRF serializers
│   ├── views.py               # API views
│   └── urls.py                # API URL routes
├── init.sh                    # Setup script
├── run.sh                     # Start dev server
├── stop.sh                    # Stop dev server
├── Dockerfile                 # Container build
├── .env.example               # Environment template
└── .gitignore
```

## Scripts

| Script    | Purpose                                                       |
| --------- | ------------------------------------------------------------- |
| `init.sh` | Create venv, install dependencies, copy `.env`, run migrations |
| `run.sh`  | Activate venv, start `manage.py runserver` on configured port  |
| `stop.sh` | Kill the process listening on the configured port              |

## API Endpoints

| Method | Path              | Description         |
| ------ | ----------------- | ------------------- |
| GET    | `/api/health/`    | Health check        |
| GET    | `/api/items/`     | List all items      |
| POST   | `/api/items/`     | Create an item      |
| GET    | `/api/items/:id/` | Get item by ID      |
| PUT    | `/api/items/:id/` | Update item by ID   |
| DELETE | `/api/items/:id/` | Delete item by ID   |

## Environment Variables

| Variable        | Default                  | Description                 |
| --------------- | ------------------------ | --------------------------- |
| `SECRET_KEY`    | `change-me-in-production`| Django secret key           |
| `DEBUG`         | `True`                   | Debug mode                  |
| `PORT`          | `8000`                   | Dev server port             |
| `ALLOWED_HOSTS` | `localhost,127.0.0.1`    | Comma-separated hostnames   |
| `CORS_ORIGIN`   | `http://localhost:3000`  | CORS allowed origins        |

## Common Commands

```bash
# Create superuser
python manage.py createsuperuser

# Make migrations after model changes
python manage.py makemigrations

# Apply migrations
python manage.py migrate

# Open Django shell
python manage.py shell

# Run tests
python manage.py test
```

## Docker

```bash
docker build -t {{APP_NAME}} .
docker run -p 8000:8000 {{APP_NAME}}
```
