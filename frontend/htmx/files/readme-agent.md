# Agent Instructions — {{PROJECT_NAME}}

This is a hypermedia-driven web app using HTMX with Express and EJS templates.

## Tech Stack
- **UI**: HTMX 2.x (loaded via CDN)
- **Server**: Express (Node.js)
- **Templates**: EJS (server-rendered HTML)
- **CSS**: Vanilla CSS (no build step)

## Key Conventions
- Server endpoints return **HTML fragments**, not JSON
- Use HTMX attributes (hx-get, hx-post, hx-target, hx-swap) for interactivity
- Partials in `views/partials/` are HTML fragments returned by AJAX endpoints
- Full pages use `layout.ejs` wrapper, partials do NOT include layout
- Use `hx-target` to specify where response HTML goes in the DOM
- Use `hx-swap` to control insertion: innerHTML, outerHTML, beforeend, afterend
- No client-side JavaScript framework — all state lives on the server
- Use `hx-indicator` class for loading spinners
- Toast/flash messages: render a toast partial and swap into a notifications area
- For forms, `hx-post` / `hx-put` with `hx-target` replaces the relevant section
