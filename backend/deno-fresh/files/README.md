# {{PROJECT_NAME}}

[Fresh](https://fresh.deno.dev/) is a next-gen web framework for Deno with islands architecture.

## Getting Started

```bash
bash init.sh    # install Deno (if needed)
bash run.sh     # start dev server (port 8000)
bash stop.sh    # stop dev server
```

## Project Structure

```
routes/
  index.tsx          # Home page (server-rendered)
  about.tsx          # About page
  api/
    joke.ts          # API route (JSON)
    greet/[name].ts  # Dynamic API route
islands/
  Counter.tsx        # Interactive counter (hydrated on client)
components/
  Header.tsx         # Static header component
static/
  styles.css         # Global styles
deno.json            # Deno config + import map
dev.ts               # Dev entry point
main.ts              # Production entry point
fresh.gen.ts         # Auto-generated manifest
```

## Key Concepts

- **Routes**: File-based routing in `routes/`. Rendered on the server.
- **Islands**: Interactive components in `islands/`. Only these ship JS to the client.
- **API Routes**: Files in `routes/api/` that export handlers.
- **Zero JS by default**: Static components don't send JavaScript to the browser.

## Requirements

- Deno >= 1.40
