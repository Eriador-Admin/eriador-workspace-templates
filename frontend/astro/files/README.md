# {{APP_NAME}}

An [Astro](https://astro.build/) content-driven static site.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start dev server on port {{DEV_PORT}}
```

## Project Structure

```
src/
  layouts/       # Page layouts
  pages/         # File-based routing (.astro files)
  components/    # Reusable Astro/framework components
public/          # Static assets served as-is
```

## Commands

| Command         | Action                            |
|:----------------|:----------------------------------|
| `npm install`   | Install dependencies              |
| `npm run dev`   | Start dev server at `localhost:{{DEV_PORT}}` |
| `npm run build` | Build production site to `./dist` |
| `npm run preview` | Preview production build locally |

## Learn More

- [Astro Documentation](https://docs.astro.build)
- [Astro Integrations](https://astro.build/integrations/)
