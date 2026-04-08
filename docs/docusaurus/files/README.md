# {{PROJECT_NAME}}

A documentation site built with [Docusaurus](https://docusaurus.io/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server
bash stop.sh    # stop dev server
```

## Project Structure

```
docs/           # Markdown/MDX documentation pages
src/            # Custom React components and pages
static/         # Static assets (images, etc.)
docusaurus.config.js  # Site configuration
sidebars.js     # Sidebar navigation
```

## Writing Docs

Add `.md` or `.mdx` files to the `docs/` directory. They will automatically appear in the sidebar.

```md
---
sidebar_position: 1
---

# My Page Title

Content goes here.
```

## Requirements

- Node.js 18+
