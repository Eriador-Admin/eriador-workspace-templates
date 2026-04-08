# Agent Instructions — {{PROJECT_NAME}}

This is a Supabase BaaS project.

## Tech Stack
- **BaaS**: Supabase (Postgres, Auth, Realtime, Storage)
- **App Server**: Express + TypeScript
- **Client**: @supabase/supabase-js

## Key Conventions
- Entry point: `src/app.ts`
- Supabase client in `src/supabase.ts`
- Auth middleware extracts JWT from Authorization header
- Database migrations in `supabase/migrations/`
- Row Level Security (RLS) is enabled on all tables
