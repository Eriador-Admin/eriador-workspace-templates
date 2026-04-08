# {{PROJECT_NAME}}

A static site built with [Hugo](https://gohugo.io/).

## Getting Started

```bash
bash init.sh    # install Hugo theme
bash run.sh     # start dev server
bash stop.sh    # stop dev server
```

## Project Structure

```
content/        # Markdown content pages
layouts/        # HTML layout templates (overrides)
static/         # Static assets
themes/         # Hugo themes (git submodules)
hugo.toml       # Site configuration
```

## Creating Content

```bash
hugo new content/posts/my-first-post.md
```

## Requirements

- Hugo extended (v0.120+)
- Git (for theme installation)
