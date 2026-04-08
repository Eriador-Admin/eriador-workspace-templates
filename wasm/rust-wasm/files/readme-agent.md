# Agent Instructions — {{PROJECT_NAME}}

This is a Rust-to-WebAssembly project.

## Tech Stack
- **Language**: Rust
- **Build Tool**: wasm-pack
- **Bindings**: wasm-bindgen
- **Target**: WebAssembly (browser)

## Key Conventions
- Rust source in `src/lib.rs`
- `#[wasm_bindgen]` attribute exposes functions to JavaScript
- WASM output goes to `pkg/` directory
- Web demo in `www/` directory
