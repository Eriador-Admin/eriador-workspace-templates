# Agent Instructions — {{FUNCTION_NAME}}

This is an Azure Functions v4 application using the Node.js programming model v4.

## Tech Stack
- **Runtime**: Node.js 20 / TypeScript
- **Framework**: Azure Functions v4 (programming model v4)
- **Local Dev**: Azure Functions Core Tools

## Key Conventions
- Functions defined in `src/functions/` using `app.http()`, `app.timer()`, etc.
- Each function file registers itself with the Azure Functions runtime
- Uses the v4 programming model (function-level registration, not function.json)
- TypeScript compiled to `dist/`
- `host.json` configures runtime behavior

## File Patterns
- `src/functions/*.ts` → Function definitions
- `host.json` → Runtime configuration
- `local.settings.json` → Local environment variables
