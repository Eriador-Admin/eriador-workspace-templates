# {{PROJECT_NAME}}

[Gatsby](https://www.gatsbyjs.com/) static site with TypeScript, MDX blog, and image optimization.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server (port 8000)
bash stop.sh    # stop dev server
```

## Project Structure

```
src/
  pages/
    index.tsx        # Home page
    blog.tsx         # Blog listing page
    404.tsx          # 404 page
  components/
    Layout.tsx       # Site layout wrapper
    Seo.tsx          # SEO head component
  templates/
    blog-post.tsx    # MDX blog post template
content/
  blog/
    hello-world.mdx  # Sample blog post
gatsby-config.ts     # Gatsby configuration
gatsby-node.ts       # Page creation from MDX
```

## Features

- TypeScript throughout
- MDX blog with frontmatter (title, date, description)
- SEO component with meta tags
- File-system routing + programmatic page creation
- CSS Modules support

## Adding a Blog Post

Create a new `.mdx` file in `content/blog/`:

```mdx
---
title: "My New Post"
date: "2025-02-01"
description: "A great new post"
---

Content goes here with **MDX** support.
```

## Requirements

- Node.js >= 18
