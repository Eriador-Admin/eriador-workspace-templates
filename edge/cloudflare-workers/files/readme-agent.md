# Agent Instructions — {{PROJECT_NAME}}

This is a Cloudflare Workers edge project.

## Tech Stack
- **Runtime**: Cloudflare Workers (V8 isolate)
- **Storage**: Workers KV
- **Dev Tool**: Wrangler

## Key Conventions
- Entry point: `src/index.ts`
- Worker exports a default `fetch` handler
- KV bindings defined in `wrangler.toml`
- Local dev uses `wrangler dev` (simulates edge locally)
- No Node.js APIs — uses Web Standards (Request/Response/fetch)
