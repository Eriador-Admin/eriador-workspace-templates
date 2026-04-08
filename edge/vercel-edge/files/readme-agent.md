# Agent Instructions — {{PROJECT_NAME}}

This is a Vercel Edge Functions project using Next.js App Router.

## Tech Stack
- **Framework**: Next.js 14+ (App Router)
- **Runtime**: Vercel Edge Runtime
- **Language**: TypeScript

## Key Conventions
- Edge functions use `export const runtime = "edge"` in route handlers
- Edge middleware in root `middleware.ts` — runs before every request
- Use Web Standard APIs: `Request`, `Response`, `Headers`, `URL`
- No Node.js APIs in edge (no `fs`, `path`, `Buffer` etc.)
- Access geo data via `request.geo` (city, country, region, latitude, longitude)
- Access IP via `request.ip`
- `NextRequest` / `NextResponse` extend Web APIs with helpers
- `middleware.ts` can rewrite, redirect, set headers, or return early
- Edge functions have 25ms CPU time limit — keep logic fast
- Use `waitUntil()` for fire-and-forget background work
- Config matcher in middleware limits which paths it runs on
