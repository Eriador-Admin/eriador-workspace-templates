# {{PROJECT_NAME}}

A hypermedia-driven web application using [HTMX](https://htmx.org/) — access modern browser features directly from HTML without writing JavaScript. Server returns HTML fragments, not JSON.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start on port 3000
bash stop.sh    # stop server
```

## Prerequisites

- Node.js 18+

## Project Structure

```
server.js                   # Express server
public/
  css/
    style.css               # App styles
views/
  layout.ejs                # Base HTML layout (head, htmx script)
  index.ejs                 # Home page
  partials/
    item-list.ejs           # Items list fragment
    item-row.ejs            # Single item row fragment
    item-form.ejs           # Create/edit form fragment
    toast.ejs               # Toast notification fragment
```

## HTMX Concepts

- **hx-get / hx-post / hx-put / hx-delete** — HTTP verbs as HTML attributes
- **hx-target** — Where to put the response HTML
- **hx-swap** — How to swap content (innerHTML, outerHTML, beforeend, etc.)
- **hx-trigger** — What triggers the request (click, submit, load, etc.)
- **hx-indicator** — Show loading state during requests
- **hx-confirm** — Browser confirm dialog before request

## Key Patterns

```html
<!-- Load items on page load -->
<div hx-get="/items" hx-trigger="load" hx-target="#item-list">
  Loading...
</div>

<!-- Create via form submission -->
<form hx-post="/items" hx-target="#item-list" hx-swap="innerHTML">

<!-- Delete with confirmation -->
<button hx-delete="/items/1" hx-confirm="Are you sure?" hx-target="closest tr" hx-swap="outerHTML">
  Delete
</button>
```

Server returns HTML fragments, not JSON. No client-side routing or build step needed.
