# Agent Instructions — {{APP_NAME}}

This is a Flask REST API project.

## Tech Stack
- **Framework**: Flask 3.x
- **ORM**: SQLAlchemy (Flask-SQLAlchemy)
- **Testing**: pytest
- **Language**: Python 3.11+

## Key Conventions
- App factory pattern in `app/__init__.py`
- Blueprints in `app/routes/` for route organization
- Models in `app/models/` with SQLAlchemy
- Business logic in `app/services/`
- Configuration in `app/config.py` via environment variables
- Tests in `tests/` using pytest

## File Patterns
- `app/routes/*.py` → API endpoints (Blueprints)
- `app/models/*.py` → Database models
- `app/services/*.py` → Business logic layer
- `tests/test_*.py` → Test files
