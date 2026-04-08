# Agent Instructions — {{PROJECT_NAME}}

This is a Hono web API project.

## Tech Stack
- **Framework**: Hono 4.x
- **Language**: TypeScript
- **Validation**: Zod
- **Runtime**: Node.js (also works on Bun, Deno, CF Workers)

## Key Conventions
- Import from `hono` for core, `hono/validator` for validation
- Routes use chained `.get()`, `.post()`, `.put()`, `.delete()` on Hono instance
- Use `c.json()` to return JSON, `c.text()` for text, `c.html()` for HTML
- `c.req.param('id')` for path params, `c.req.query('q')` for query
- `c.req.json()` to parse JSON request body
- Middleware via `app.use('*', middlewareFn)` or route-specific
- Validation with `@hono/zod-validator` — validates req body/params/query
- Error handling: `app.onError()` global handler
- Group routes with `new Hono()` sub-apps and `app.route('/prefix', subApp)`
- For Node.js adapter: `import { serve } from '@hono/node-server'`
- Context `c` is the single param — contains req, env, var, etc.
