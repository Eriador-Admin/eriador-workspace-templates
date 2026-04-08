# {{PROJECT_NAME}}

A full-stack app with a Django REST Framework backend and React (Vite) frontend.

## Getting Started

```bash
bash init.sh    # install backend + frontend dependencies
bash run.sh     # start both servers
bash stop.sh    # stop both servers
```

- Backend API: http://localhost:{{DEV_PORT}}/api/
- Frontend: http://localhost:5173

## Project Structure

```
backend/
  manage.py
  config/
    settings.py       # Django settings
    urls.py           # Root URL config
  api/
    views.py          # API views
    urls.py           # API routes
    serializers.py    # DRF serializers
  requirements.txt
frontend/
  src/
    App.tsx           # React root component
    main.tsx          # Entry point
  package.json
  vite.config.ts
```

## Requirements

- Python 3.9+
- Node.js 18+
