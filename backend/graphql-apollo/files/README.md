# {{APP_NAME}}

A GraphQL API built with Apollo Server and TypeScript.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the server
bash stop.sh    # stop the server
```

## Project Structure

```
src/
  index.ts          # Server entry point
  schema/
    typeDefs.ts     # GraphQL type definitions
    resolvers.ts    # Query/mutation resolvers
  data/
    store.ts        # In-memory data store
```

## API

Visit `http://localhost:{{DEV_PORT}}` for Apollo Sandbox (interactive GraphQL IDE).

### Example Query

```graphql
query {
  books {
    id
    title
    author
  }
}
```

## Requirements

- Node.js 18+
