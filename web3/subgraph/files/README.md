# {{PROJECT_NAME}}

[The Graph](https://thegraph.com/) subgraph for indexing Ethereum smart contract events with GraphQL.

## Getting Started

```bash
bash init.sh    # install deps + start local Graph node
bash run.sh     # deploy subgraph to local node
bash stop.sh    # stop Graph node
```

## What is a Subgraph?

A subgraph indexes blockchain events into a queryable GraphQL API. Instead of scanning blocks yourself, The Graph watches for events and stores structured data you define.

## Architecture

```
Ethereum Node ──► Graph Node ──► PostgreSQL
                      │
                      ▼
               GraphQL API
              (localhost:8000)
```

## Project Structure

```
subgraph.yaml           # Subgraph manifest (data sources, handlers)
schema.graphql          # GraphQL schema (entities)
src/
  mapping.ts            # Event handlers (AssemblyScript)
abis/
  Counter.json          # Contract ABI
tests/
  mapping.test.ts       # Matchstick unit tests
docker-compose.yml      # Local Graph Node + IPFS + PostgreSQL
```

## Workflow

1. Define entities in `schema.graphql`
2. Map events to entities in `src/mapping.ts`
3. Run `graph codegen` to generate types
4. Run `graph build` to compile
5. Deploy to local or hosted Graph Node

## Example Query

```graphql
{
  numberChangeds(first: 10, orderBy: blockTimestamp, orderDirection: desc) {
    id
    oldNumber
    newNumber
    blockTimestamp
    transactionHash
  }
}
```

## Local Graph Node

- GraphQL endpoint: `http://localhost:8000/subgraphs/name/{{PROJECT_NAME}}`
- GraphQL playground: `http://localhost:8000`
- IPFS: `http://localhost:5001`
- Admin: `http://localhost:8020`

## Requirements

- Docker + Docker Compose
- Node.js >= 18
