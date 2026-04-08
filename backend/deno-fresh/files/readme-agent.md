# Agent Instructions — {{PROJECT_NAME}}

This is a Deno Fresh project with islands architecture.

## Tech Stack
- **Runtime**: Deno
- **Framework**: Fresh
- **UI**: Preact (JSX)
- **Styling**: CSS (no build step)

## Key Conventions
- Routes in `routes/` (file-based, server-rendered)
- Islands in `islands/` (client-interactive components)
- Static components in `components/` (no client JS)
- API routes export `Handlers` (GET, POST, etc.)
- Use `deno.json` for import maps and tasks
- No node_modules — Deno uses URL imports
