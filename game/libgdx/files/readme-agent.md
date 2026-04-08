# Agent Instructions — {{PROJECT_NAME}}

This is a cross-platform game built with libGDX in Java.

## Tech Stack
- **Language**: Java 17+
- **Framework**: libGDX 1.12+
- **Build**: Gradle (wrapper included)
- **Desktop Backend**: LWJGL3

## Key Conventions
- Core game code in `core/src/`
- Platform launchers in `desktop/src/`, `android/`, etc.
- Main class extends `ApplicationAdapter` or implements `Screen`
- Game loop: `create()` → `render()` (called every frame) → `dispose()`
- Use `Gdx.graphics.getDeltaTime()` for delta time
- Use `Gdx.input.isKeyPressed()` for input
- Rendering via `SpriteBatch` (begin/draw/end)
- Use `ShapeRenderer` for debug/primitive drawing
- Textures loaded via `new Texture()` or `AssetManager`
- Always `dispose()` textures, batches, fonts in `dispose()`
- Use `OrthographicCamera` for 2D, `PerspectiveCamera` for 3D
