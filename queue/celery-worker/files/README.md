# {{PROJECT_NAME}}

Python task queue with [Celery](https://docs.celeryq.dev/) and Redis, monitored via [Flower](https://flower.readthedocs.io/).

## Getting Started

```bash
bash init.sh    # install deps and start Redis
bash run.sh     # start worker + Flower dashboard
bash stop.sh    # stop everything
```

Flower dashboard: http://localhost:{{DEV_PORT}}

## Project Structure

```
app/
  celery_app.py     # Celery application setup
  tasks/
    email.py        # Example email task
    report.py       # Example report task
  producer.py       # CLI to dispatch test tasks
docker-compose.yml  # Redis container
requirements.txt
```

## Requirements

- Python 3.9+
- Docker (for Redis)
