# Agent Instructions — {{PACKAGE_NAME}}

This is a TypeScript npm package project.

## Tech Stack
- **Language**: TypeScript
- **Bundler**: tsup (esbuild-based)
- **Testing**: Vitest
- **Target**: Node.js + ESM/CJS dual output

## Key Conventions
- Source code in `src/`, main export from `src/index.ts`
- Tests in `tests/` using Vitest
- Build outputs CJS + ESM via tsup to `dist/`
- package.json has `exports`, `main`, `module`, `types` fields

## File Patterns
- `src/*.ts` → Source files
- `tests/*.test.ts` → Test files
- `dist/` → Build output (gitignored)
