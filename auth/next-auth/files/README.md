# {{PROJECT_NAME}}

A Next.js app with [Auth.js](https://authjs.dev/) (NextAuth v5) for authentication.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the dev server
bash stop.sh    # stop the dev server
```

Open http://localhost:{{DEV_PORT}} in your browser.

## Setup

1. Copy `.env.example` to `.env`
2. Create OAuth apps at your providers (GitHub, Google, etc.)
3. Add client IDs and secrets to `.env`
4. Generate `AUTH_SECRET`: `npx auth secret`

## Project Structure

```
app/
  layout.tsx          # Root layout with session provider
  page.tsx            # Homepage (shows auth state)
  api/auth/[...nextauth]/
    route.ts          # Auth.js API handler
  dashboard/
    page.tsx          # Protected page
auth.ts               # Auth.js configuration
middleware.ts          # Route protection middleware
```

## Requirements

- Node.js 18+
