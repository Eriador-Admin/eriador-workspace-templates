# {{PROJECT_NAME}}

A headless CMS built with [Strapi](https://strapi.io/).

## Getting Started

```bash
bash init.sh    # create Strapi project
bash run.sh     # start dev server
bash stop.sh    # stop server
```

Visit `http://localhost:{{DEV_PORT}}/admin` to access the admin panel.

## Project Structure

```
config/         # Server, database, middleware, API, and plugin configuration
database/
  migrations/   # Optional database migrations
src/
  index.js      # register() / bootstrap() lifecycle hooks
  api/          # Content type definitions and controllers
  admin/        # Admin panel customization (rename *.example.js to enable)
  extensions/   # Plugin extensions
public/         # Public assets and uploads
```

## Creating Content Types

Use the Strapi admin panel Content-Type Builder or create them in `src/api/`.

## Requirements

- Node.js 22–26 (Strapi 5 engine range)
