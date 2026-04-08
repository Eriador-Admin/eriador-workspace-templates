# Agent Instructions — {{PROJECT_NAME}}

This is a cross-platform game built with MonoGame in C#.

## Tech Stack
- **Language**: C# (.NET 8)
- **Framework**: MonoGame 3.8+
- **Content**: MGCB content pipeline

## Key Conventions
- Main class extends `Game` (MonoGame.Framework)
- Game loop: `Initialize()` → `LoadContent()` → `Update(GameTime)` / `Draw(GameTime)`
- Use `SpriteBatch` for 2D rendering (Begin/Draw/End)
- Use `Content.Load<Texture2D>("name")` for loading assets
- Assets processed through MGCB pipeline in `Content/Content.mgcb`
- Use `gameTime.ElapsedGameTime.TotalSeconds` for delta time
- Use `Keyboard.GetState()` for input
- Use `Rectangle.Intersects()` for AABB collision
- Textures created at runtime with `new Texture2D(GraphicsDevice, w, h)` + `SetData<Color>()`
- Default is 60 FPS fixed timestep, configurable via `TargetElapsedTime`
