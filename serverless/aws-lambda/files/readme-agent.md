# Agent Instructions — {{FUNCTION_NAME}}

This is an AWS Lambda serverless application using SAM.

## Tech Stack
- **Runtime**: Node.js ({{RUNTIME}})
- **IaC**: AWS SAM (template.yaml)
- **Local Dev**: SAM CLI local invoke / start-api

## Key Conventions
- Handler functions in `src/handlers/`
- Each handler exports a named function matching template.yaml
- Use ES modules (.mjs) with top-level await
- SAM template.yaml defines all resources (functions, APIs, tables)
- Test events in `events/`

## File Patterns
- `src/handlers/*.mjs` → Lambda handler functions
- `template.yaml` → SAM/CloudFormation template
- `events/*.json` → Test event payloads
