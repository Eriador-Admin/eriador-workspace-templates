# {{PROJECT_NAME}}

[Supabase](https://supabase.com/) starter with auth, database, realtime, and storage.

## Getting Started

```bash
bash init.sh    # install deps
bash run.sh     # start the API
bash stop.sh    # stop everything
```

## Setup

1. Create a project at [supabase.com](https://supabase.com/)
2. Go to Settings > API and copy your project URL + anon key
3. Copy `.env.example` to `.env` and fill in your keys
4. Run the SQL in `supabase/migrations/001_init.sql` in the Supabase SQL editor

## Endpoints

| Method | URL | Description |
|--------|-----|-------------|
| POST | `/auth/signup` | Register a new user |
| POST | `/auth/login` | Sign in with email/password |
| GET | `/todos` | List todos (requires auth) |
| POST | `/todos` | Create a todo (requires auth) |
| PATCH | `/todos/:id` | Update a todo (requires auth) |
| DELETE | `/todos/:id` | Delete a todo (requires auth) |
| POST | `/storage/upload` | Upload a file |
| GET | `/health` | Health check |

## Project Structure

```
src/
  app.ts              # Express API
  supabase.ts         # Supabase client setup
  middleware/auth.ts   # JWT auth middleware
  routes/auth.ts      # Auth routes
  routes/todos.ts     # CRUD routes
  routes/storage.ts   # File upload routes
supabase/
  migrations/001_init.sql  # Database schema
```

## Requirements

- Node.js 18+
- Supabase account (free tier available)
