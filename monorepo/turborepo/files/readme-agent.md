# Agent Instructions — {{PROJECT_NAME}}

This is a Turborepo monorepo.

## Tech Stack
- **Build System**: Turborepo
- **Package Manager**: npm workspaces
- **Language**: TypeScript

## Key Conventions
- Apps in `apps/` directory (web, api)
- Shared packages in `packages/` directory
- Turborepo pipeline defined in `turbo.json`
- Each package has its own `package.json`
- Shared code imported via workspace references
