# Agent Instructions — {{PROJECT_NAME}}

This is a game built with the Bevy engine in Rust.

## Tech Stack
- **Language**: Rust (stable)
- **Engine**: Bevy 0.14
- **Architecture**: Entity Component System (ECS)

## Key Conventions
- Entry point: `src/main.rs`
- Components are marker structs or data structs with `#[derive(Component)]`
- Systems are plain functions with `Query<>`, `Res<>`, `Commands` parameters
- Use `App::new().add_plugins(DefaultPlugins)` for standard setup
- Systems registered via `.add_systems(Update, system_fn)` or schedules
- Resources are global singletons with `#[derive(Resource)]`
- Use `Time` resource for delta time: `time.delta_secs()`
- Use `Input<KeyCode>` resource for keyboard input
- Bundles group components: `SpriteBundle`, `Camera2dBundle`
- Assets loaded via `AssetServer`: `asset_server.load("sprite.png")`
- Fast compile: use `bevy/dynamic_linking` feature in dev
