# {{APP_NAME}}

A REST API built with [Flask](https://flask.palletsprojects.com/).

## Getting Started

```bash
bash init.sh    # create venv and install dependencies
bash run.sh     # start dev server on port {{DEV_PORT}}
bash stop.sh    # stop the dev server
```

## Project Structure

```
app/
  __init__.py      # App factory
  config.py        # Configuration
  models/          # SQLAlchemy models
  routes/          # Blueprint routes
  services/        # Business logic
tests/
  test_health.py   # Example test
```

## API Endpoints

| Method | Path        | Description    |
|:-------|:------------|:---------------|
| GET    | `/health`   | Health check   |
| GET    | `/api/items`| List items     |
| POST   | `/api/items`| Create item    |

## Testing

```bash
source venv/bin/activate
pytest
```
