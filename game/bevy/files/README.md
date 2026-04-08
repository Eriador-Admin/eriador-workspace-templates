# {{PROJECT_NAME}}

A game built with [Bevy](https://bevyengine.org/) — a data-driven Rust game engine using Entity Component System (ECS) architecture. Features 2D sprite rendering, keyboard input, and collision detection.

## Getting Started

```bash
bash init.sh    # build the project (first build downloads + compiles deps)
bash run.sh     # run the game
bash stop.sh    # stop
```

## Prerequisites

- [Rust](https://rustup.rs/) (stable, latest)
- System dependencies for Bevy:
  - macOS: Xcode command line tools
  - Linux: `sudo apt install g++ pkg-config libx11-dev libasound2-dev libudev-dev`

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
src/
  main.rs              # App setup, plugins, startup system
  components.rs        # ECS components (Player, Enemy, Bullet, Velocity)
  systems/
    movement.rs        # Movement + boundary systems
    combat.rs          # Shooting + collision systems
    spawner.rs         # Enemy spawner system
Cargo.toml             # Dependencies (bevy)
```

## ECS Architecture

- **Entities**: Game objects (player, enemies, bullets) — just an ID
- **Components**: Data attached to entities (`Transform`, `Velocity`, `Player`)
- **Systems**: Functions that operate on entities with specific components

```
App::new()
  .add_plugins(DefaultPlugins)
  .add_systems(Startup, setup)
  .add_systems(Update, (movement, combat, spawner))
```

## Building for Web (WASM)

```bash
rustup target add wasm32-unknown-unknown
cargo install wasm-bindgen-cli
cargo build --release --target wasm32-unknown-unknown
wasm-bindgen --out-dir web --target web target/wasm32-unknown-unknown/release/{{PROJECT_NAME}}.wasm
```
