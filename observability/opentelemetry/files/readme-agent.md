# Agent Instructions — {{PROJECT_NAME}}

This is a Node.js app instrumented with OpenTelemetry.

## Tech Stack
- **Framework**: Express
- **Observability**: OpenTelemetry SDK (auto-instrumentation)
- **Trace Backend**: Jaeger (via Docker)
- **Export Protocol**: OTLP over gRPC

## Key Conventions
- `src/tracing.js` MUST be loaded before any other modules (via `--require`)
- `src/app.js` is a normal Express app — instrumentation is transparent
- Jaeger runs via docker-compose on port 16686 (UI) and 4317 (OTLP)
