# {{PROJECT_NAME}}

A Rust library crate.

## Getting Started

```bash
bash init.sh    # verify Rust toolchain
bash run.sh     # run tests
bash stop.sh    # (no-op for libraries)
```

## Project Structure

```
src/
  lib.rs          # Library entry point
  utils.rs        # Utility module
tests/
  integration.rs  # Integration tests
```

## Usage

```rust
use {{PROJECT_NAME}}::add;

let result = add(2, 3);
assert_eq!(result, 5);
```

## Requirements

- Rust 1.75+ (install via https://rustup.rs)
