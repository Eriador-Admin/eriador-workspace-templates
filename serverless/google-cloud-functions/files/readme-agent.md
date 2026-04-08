# Agent Instructions — {{FUNCTION_NAME}}

This is a Google Cloud Functions serverless application.

## Tech Stack
- **Runtime**: Node.js 20
- **Framework**: Google Cloud Functions Framework
- **Local Dev**: @google-cloud/functions-framework

## Key Conventions
- Functions exported from `index.js`
- Each export can be a separate Cloud Function
- Use `functions.http()` for HTTP triggers
- Use `functions.cloudEvent()` for event triggers
- Local testing via functions-framework CLI

## File Patterns
- `index.js` → Function entry points
- `test/*.test.js` → Unit tests
