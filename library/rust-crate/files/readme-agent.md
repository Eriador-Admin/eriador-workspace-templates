# Agent Instructions — {{PROJECT_NAME}}

This is a Rust library crate.

## Tech Stack
- **Language**: Rust
- **Build**: Cargo

## Key Conventions
- Library entry point: `src/lib.rs`
- Modules in `src/` with `pub mod` declarations in lib.rs
- Integration tests in `tests/`
- Unit tests in `#[cfg(test)] mod tests` blocks inline
- Run tests with `cargo test`
- Generate docs with `cargo doc --open`
