# {{PROJECT_NAME}}

A Shopify theme built with Online Store 2.0, Liquid, and JSON templates.

## Getting Started

```bash
bash init.sh    # install Shopify CLI
bash run.sh     # start theme development server
bash stop.sh    # stop the dev server
```

## Project Structure

```
layout/
  theme.liquid        # Main layout wrapper
templates/
  index.json          # Homepage template (OS 2.0 JSON)
  product.json        # Product page template
sections/
  header.liquid       # Header section
  hero-banner.liquid  # Hero banner section
  featured-collection.liquid  # Product grid section
  footer.liquid       # Footer section
snippets/
  product-card.liquid # Reusable product card
config/
  settings_schema.json  # Theme settings definition
assets/
  theme.css           # Main stylesheet
  theme.js            # Main JavaScript
locales/
  en.default.json     # English translations
```

## Requirements

- Shopify CLI 3+
- Node.js 18+
- A Shopify Partner account and development store
