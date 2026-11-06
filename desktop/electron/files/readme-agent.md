# Agent Instructions — {{APP_NAME}}

This is an Electron desktop application with React.

## Tech Stack
- **Framework**: Electron (main + renderer processes)
- **UI**: React + TypeScript
- **Bundler**: Vite (renderer), tsc (main)

## Key Conventions
- Main process: `src/main/index.ts` — creates BrowserWindow, handles IPC (`get-version` is answered by `ipcMain.handle`)
- `npm run dev` starts Electron with `--dev`, so the window loads the Vite dev server instead of `dist/renderer`
- The renderer is built with `base: './'` because the packaged window loads `index.html` from disk
- Preload: `src/main/preload.ts` — exposes safe APIs via contextBridge
- Renderer: `src/renderer/` — standard React app loaded in BrowserWindow
- IPC communication between main and renderer via preload bridge
- Context isolation enabled, nodeIntegration disabled (security best practice)

## File Patterns
- `src/main/*.ts` → Electron main process
- `src/renderer/*.tsx` → React renderer UI
- `src/renderer/index.html` → HTML entry point
