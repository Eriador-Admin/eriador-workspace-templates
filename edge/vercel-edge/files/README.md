# {{PROJECT_NAME}}

[Vercel Edge Functions](https://vercel.com/docs/functions/edge-functions) running at the edge for ultra-low latency. Built with Next.js App Router and TypeScript.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server on port 3000
bash stop.sh    # stop dev server
```

## Prerequisites

- Node.js 18+
- Vercel account (for deployment)

## Project Structure

```
app/
  layout.tsx                    # Root layout
  page.tsx                      # Home page
  api/
    hello/route.ts              # Edge API: JSON response
    geo/route.ts                # Edge API: geolocation data
    rewrite/route.ts            # Edge API: conditional rewrite
middleware.ts                   # Edge Middleware (runs on every request)
lib/
  edge-utils.ts                 # Shared edge utilities
vercel.json                     # Vercel config
```

## Edge Function Examples

| Endpoint | Description |
|----------|-------------|
| `/api/hello` | Simple JSON response with edge headers |
| `/api/geo` | Returns visitor geolocation from edge |
| `/api/rewrite` | Conditional rewrite based on user-agent |
| Middleware | Adds security headers, geo header, request timing |

## Deploying

```bash
npx vercel          # deploy to preview
npx vercel --prod   # deploy to production
```
