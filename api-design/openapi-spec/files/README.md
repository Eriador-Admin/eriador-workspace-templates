# {{PROJECT_NAME}}

API design-first workflow with [OpenAPI 3.1](https://spec.openapis.org/oas/v3.1.0).

## Getting Started

```bash
bash init.sh    # install tools
bash run.sh     # serve Swagger UI
bash stop.sh    # stop server
```

Visit `http://localhost:{{DEV_PORT}}` to view the interactive API documentation.

## Project Structure

```
spec/
  openapi.yaml    # Main OpenAPI specification
  paths/          # Path definitions (split files)
  schemas/        # Schema definitions (split files)
```

## Workflow

1. Edit the OpenAPI spec in `spec/openapi.yaml`
2. View changes live in Swagger UI
3. Validate with `npx @redocly/cli lint spec/openapi.yaml`
4. Generate server/client code from the spec

## Requirements

- Node.js 18+
