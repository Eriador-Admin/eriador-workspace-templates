# {{PROJECT_NAME}}

[Cloudflare Workers](https://workers.cloudflare.com/) edge application with KV storage and local dev.

## Getting Started

```bash
bash init.sh    # install deps
bash run.sh     # start local dev server
bash stop.sh    # stop dev server
```

## Routes

| Method | URL | Description |
|--------|-----|-------------|
| GET | `/` | Hello from the edge |
| GET | `/api/kv/:key` | Get value from KV |
| PUT | `/api/kv/:key` | Set value in KV |
| DELETE | `/api/kv/:key` | Delete from KV |
| GET | `/api/geo` | Return request geolocation |

## Deployment

```bash
npx wrangler deploy           # deploy to Cloudflare
npx wrangler tail              # view live logs
npx wrangler kv:namespace create MY_KV  # create production KV
```

## Project Structure

```
src/
  index.ts      # Worker entry point + router
  router.ts     # Simple path-based router
  kv.ts         # KV storage handlers
wrangler.toml   # Wrangler config
```

## Requirements

- Node.js 18+
- Cloudflare account (free tier available)
- Wrangler CLI (installed via npm)
