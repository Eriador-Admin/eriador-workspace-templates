# Agent Instructions — {{PROJECT_NAME}}

This is a Temporal workflow orchestration project.

## Tech Stack
- **Workflows**: Temporal (TypeScript SDK)
- **App Server**: Express (trigger API)
- **Infrastructure**: Temporal Server (Docker)

## Key Conventions
- Worker process: `src/worker.ts`
- API process: `src/api.ts`
- Workflows must be deterministic — no side effects
- Activities handle all I/O operations
- Task queue name defined in both worker and client
- Temporal UI at port 8233
