# Agent Instructions — {{APP_NAME}}

This is a Tauri desktop application with a Rust backend and React frontend.

## Tech Stack
- **Framework**: Tauri v1 (Rust + WebView)
- **Frontend**: React + TypeScript + Vite
- **Backend**: Rust (Tauri commands)

## Key Conventions
- Frontend (React) in `src/` — standard Vite + React
- Backend (Rust) in `src-tauri/` — Tauri commands and system access
- Communication via `@tauri-apps/api` invoke for Rust commands
- Tauri commands are `#[tauri::command]` annotated Rust functions
- Config in `src-tauri/tauri.conf.json`

## File Patterns
- `src/*.tsx` → React frontend
- `src-tauri/src/main.rs` → Tauri entry + Rust commands
- `src-tauri/tauri.conf.json` → Window/build/security config
- `src-tauri/Cargo.toml` → Rust dependencies
