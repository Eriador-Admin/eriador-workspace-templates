# Agent Instructions — {{PROJECT_NAME}}

This is a Shopify theme using Online Store 2.0.

## Tech Stack
- **Template Engine**: Liquid
- **Architecture**: Online Store 2.0 (JSON templates + sections)
- **Tools**: Shopify CLI

## Key Conventions
- Layout in `layout/theme.liquid`
- JSON templates in `templates/` enable section reordering in the theme editor
- Sections are modular, reusable blocks in `sections/`
- Snippets are partials for repeated UI in `snippets/`
- Theme settings defined in `config/settings_schema.json`
- Use `{{ 'theme.css' | asset_url | stylesheet_tag }}` for assets
