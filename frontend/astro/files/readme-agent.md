# Agent Instructions — {{APP_NAME}}

This is an Astro static site project.

## Tech Stack
- **Framework**: Astro (content-driven, islands architecture)
- **Language**: TypeScript / Astro components
- **Build**: Vite (built-in)

## Key Conventions
- Pages live in `src/pages/` and use file-based routing
- Layouts in `src/layouts/` wrap pages via the `layout` frontmatter prop
- Components in `src/components/` — `.astro` files render at build time
- Static assets go in `public/`
- Astro components use `---` frontmatter fences for server-side JS

## File Patterns
- `src/pages/*.astro` → routes (e.g., `index.astro` → `/`, `about.astro` → `/about`)
- `src/layouts/Base.astro` → shared HTML shell
- `src/components/*.astro` → reusable UI fragments
