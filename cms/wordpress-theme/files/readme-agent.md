# Agent Instructions — {{PROJECT_NAME}}

This is a WordPress theme development project.

## Tech Stack
- **CMS**: WordPress
- **Language**: PHP
- **Dev Environment**: Docker Compose (WordPress + MySQL)

## Key Conventions
- Theme files in `theme/` directory
- `style.css` contains theme metadata header
- `functions.php` for hooks, enqueues, and theme setup
- Template hierarchy: index.php, single.php, page.php, header.php, footer.php
- Docker maps `theme/` into the WordPress themes directory
