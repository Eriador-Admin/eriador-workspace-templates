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
npm run build
npm run package    # creates platform-specific bundle
```

## Requirements

- Node.js 18+
