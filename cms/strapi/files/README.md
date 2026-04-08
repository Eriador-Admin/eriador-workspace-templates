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
config/         # Server, database, and plugin configuration
src/
  api/          # Content type definitions and controllers
  admin/        # Admin panel customization
public/         # Public assets
```

## Creating Content Types

Use the Strapi admin panel Content-Type Builder or create them in `src/api/`.

## Requirements

- Node.js 18+
