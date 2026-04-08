# {{PROJECT_NAME}}

A Rust library compiled to WebAssembly using [wasm-pack](https://rustwasm.github.io/wasm-pack/).

## Getting Started

```bash
bash init.sh    # install wasm-pack & build
bash run.sh     # build WASM & serve demo
bash stop.sh    # stop demo server
```

## Project Structure

```
src/
  lib.rs          # Rust library source
www/
  index.html      # Web demo page
  index.js        # JS that loads the WASM module
Cargo.toml        # Rust package manifest
```

## Commands

```bash
wasm-pack build --target web    # Build for web
wasm-pack test --headless       # Run tests
```

## Requirements

- Rust (install via https://rustup.rs)
- wasm-pack (installed by init.sh)
