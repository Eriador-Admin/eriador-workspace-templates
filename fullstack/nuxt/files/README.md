# {{PROJECT_NAME}}

A full-stack web app built with [Nuxt 4](https://nuxt.com/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start the dev server
bash stop.sh    # stop the dev server
```

Open http://localhost:{{DEV_PORT}} in your browser.

## Project Structure

```
app/
  app.vue           # Root component
  pages/
    index.vue       # Homepage (/)
    about.vue       # About page (/about)
  layouts/
    default.vue     # Default layout
server/
  api/
    hello.ts        # API route: /api/hello
nuxt.config.ts      # Nuxt configuration
```

## Requirements

- Node.js 22.22+
