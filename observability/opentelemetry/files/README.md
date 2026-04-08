# {{PROJECT_NAME}}

A Node.js app instrumented with [OpenTelemetry](https://opentelemetry.io/) for distributed tracing, with Jaeger as the trace backend.

## Getting Started

```bash
bash init.sh    # install dependencies and start Jaeger
bash run.sh     # start the instrumented app
bash stop.sh    # stop everything
```

## Viewing Traces

Open **Jaeger UI** at http://localhost:16686 to view traces.

## Project Structure

```
src/
  tracing.js        # OpenTelemetry SDK setup (must be loaded first)
  app.js            # Express app with sample routes
docker-compose.yml  # Jaeger all-in-one container
```

## Requirements

- Node.js 18+
- Docker (for Jaeger)
