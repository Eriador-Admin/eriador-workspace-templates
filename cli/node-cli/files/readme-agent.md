# Agent Instructions — {{CLI_NAME}}

This is a Node.js CLI tool built with Commander.js.

## Tech Stack
- **Language**: TypeScript
- **CLI Framework**: Commander.js
- **Output Styling**: chalk

## Key Conventions
- Entry point: `src/index.ts` (shebang + Commander program)
- Commands in `src/commands/` — each exports a function that registers with Commander
- Utility functions in `src/utils/`
- Compiled to `dist/`, CLI binary linked via package.json `bin` field
- Use `chalk` for colored terminal output

## File Patterns
- `src/index.ts` → CLI entry point with Commander setup
- `src/commands/*.ts` → Individual command implementations
- `src/utils/*.ts` → Shared utilities
