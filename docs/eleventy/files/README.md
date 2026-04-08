# {{PROJECT_NAME}}

A static site built with [Eleventy (11ty)](https://www.11ty.dev/).

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server (port 8080)
bash stop.sh    # stop the server
```

## Project Structure

```
src/
  _data/          # Global data files
    site.json
  _includes/      # Layouts and partials
    base.njk
  posts/          # Blog posts (Markdown)
    hello-world.md
  index.njk       # Homepage
  about.md        # About page
_site/            # Built output (git-ignored)
.eleventy.js      # Eleventy configuration
```

## Writing Content

Add Markdown files to `src/posts/` with front matter:

```markdown
---
title: My Post
date: 2025-01-15
tags: posts
---
Content goes here.
```

## Requirements

- Node.js 18+
