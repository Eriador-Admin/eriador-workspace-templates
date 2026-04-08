# {{APP_NAME}}

A lightweight desktop app built with [Tauri](https://tauri.app/), Rust, and React.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start in development mode
bash stop.sh    # stop dev processes
```

## Project Structure

```
src/               # React frontend
  App.tsx
  main.tsx
src-tauri/         # Rust backend
  src/
    main.rs        # Tauri entry point + commands
  Cargo.toml
  tauri.conf.json  # Tauri configuration
```

## Build for Distribution

```bash
npm run tauri build
```

## Requirements

- Node.js 18+
- Rust (install via rustup.rs)
- Platform-specific dependencies (see Tauri prerequisites)
