# Agent Instructions — {{PROJECT_NAME}}

This is a Graph Protocol subgraph for indexing Ethereum events.

## Tech Stack
- **Indexer**: The Graph (graph-node)
- **Language**: AssemblyScript (for mappings)
- **Schema**: GraphQL
- **Testing**: Matchstick
- **Infrastructure**: Docker (graph-node + IPFS + PostgreSQL)

## Key Conventions
- Manifest: `subgraph.yaml` — data sources, event handlers, entities
- Schema: `schema.graphql` — entity definitions
- Mappings: `src/mapping.ts` — AssemblyScript event handlers
- ABIs: `abis/` — contract ABIs referenced by subgraph.yaml
- Use `graph codegen` after changing schema or ABIs
- Use `graph build` to compile
- Entity IDs must be unique strings (often tx hash + log index)
- Store entities with `entity.save()`, load with `Entity.load(id)`
