# Agent Instructions — {{PROJECT_NAME}}

This is a Python Celery task queue service.

## Tech Stack
- **Queue**: Celery
- **Broker**: Redis
- **Monitoring**: Flower
- **Language**: Python

## Key Conventions
- Celery app: `app/celery_app.py`
- Tasks in `app/tasks/`
- Use `app/producer.py` to dispatch test tasks
- Worker: `celery -A app.celery_app worker`
- Flower: `celery -A app.celery_app flower`
