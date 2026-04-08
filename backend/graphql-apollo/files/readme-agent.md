# Agent Instructions — {{APP_NAME}}

This is a GraphQL API using Apollo Server.

## Tech Stack
- **Runtime**: Node.js / TypeScript
- **GraphQL Server**: Apollo Server v4
- **Schema**: SDL-first (typeDefs + resolvers)

## Key Conventions
- Type definitions in `src/schema/typeDefs.ts` (SDL strings)
- Resolvers in `src/schema/resolvers.ts` (matching resolver map)
- Server setup in `src/index.ts` with Express + Apollo middleware
- Data layer in `src/data/` (swap for database later)

## File Patterns
- `src/schema/typeDefs.ts` → GraphQL type definitions
- `src/schema/resolvers.ts` → Resolver implementations
- `src/data/*.ts` → Data access layer
- `src/index.ts` → Server bootstrap
