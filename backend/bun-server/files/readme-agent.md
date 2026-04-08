# Agent Instructions — {{PROJECT_NAME}}

This is a Bun-native HTTP server project.

## Tech Stack
- **Runtime**: Bun 1.0+
- **Language**: TypeScript (natively supported)
- **Database**: bun:sqlite (built-in)
- **HTTP**: Bun.serve (built-in)

## Key Conventions
- Entry point uses `Bun.serve({ fetch })` — the fetch handler receives a `Request` and returns a `Response`
- No Express or framework — pure Bun APIs with a simple router
- SQLite via `import { Database } from "bun:sqlite"` — zero deps
- `.env` files loaded automatically by Bun — no dotenv needed
- Use `Bun.file()` for file reads, `Bun.write()` for writes
- Use `Bun.password.hash()` / `.verify()` for password hashing
- `bunfig.toml` for Bun-specific config (optional)
- Package manager: `bun install` (faster than npm)
- Run: `bun run src/server.ts` — no compilation needed
- Hot reload: `bun --watch src/server.ts`
- Test: `bun test` — built-in test runner
