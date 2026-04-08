# Agent Instructions — {{PROJECT_NAME}}

This is a Next.js app with Auth.js authentication.

## Tech Stack
- **Framework**: Next.js 14 (App Router)
- **Auth**: Auth.js v5 (NextAuth)
- **Language**: TypeScript

## Key Conventions
- Auth config: `auth.ts`
- Route handler: `app/api/auth/[...nextauth]/route.ts`
- Middleware: `middleware.ts` protects routes matching `/dashboard`
- Use `auth()` server-side, `useSession()` client-side
- Session provider wraps the app in `layout.tsx`
