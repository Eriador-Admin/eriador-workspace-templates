# {{APP_NAME}}

A cross-platform desktop app built with Electron, React, and TypeScript.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start in development mode
bash stop.sh    # stop dev processes
```

## Project Structure

```
src/
  main/
    index.ts        # Electron main process
    preload.ts      # Preload script (context bridge)
  renderer/
    App.tsx         # React root component
    index.tsx       # React entry point
    index.html      # HTML template
```

## Build for Distribution

```bash
npm run build      # compiles the main process and bundles the renderer into dist/
npm start          # runs the built app with Electron
```

Packaging into installers is not wired in this starter; add a packager such as Electron Forge when you need platform bundles.

## Requirements

- Node.js 22.12+
