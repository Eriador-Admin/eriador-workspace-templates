# Agent Instructions — {{PROJECT_NAME}}

This is a Neo4j graph database project.

## Tech Stack
- **Database**: Neo4j (Docker)
- **Driver**: neo4j-driver
- **App Server**: Express + TypeScript

## Key Conventions
- Entry point: `src/app.ts`
- Neo4j driver in `src/neo4j.ts`
- Uses Cypher query language
- Neo4j Browser at port 7474 for visual graph exploration
- Always close sessions after use
- Relationships are first-class (FOLLOWS, LIKES, etc.)
