# Agent Instructions — {{PROJECT_NAME}}

This is a Django + React full-stack monorepo.

## Tech Stack
- **Backend**: Django 5 + Django REST Framework
- **Frontend**: React + TypeScript + Vite
- **API**: REST (JSON)

## Key Conventions
- Backend in `backend/`, frontend in `frontend/`
- Django settings: `backend/config/settings.py`
- API views: `backend/api/views.py`
- Frontend proxies `/api` to Django via Vite config
- Run both servers simultaneously during development
