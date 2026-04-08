# Agent Instructions — {{PROJECT_NAME}}

This is a 2D game built with the Defold engine in Lua.

## Tech Stack
- **Engine**: Defold
- **Language**: Lua 5.1
- **Build**: Defold Editor / bob.jar CLI

## Key Conventions
- Project config: `game.project` (display, physics, input bindings)
- Game objects: `.go` files define entities with components
- Scripts: `.script` files contain Lua behavior (attached to game objects)
- Collections: `.collection` files are scenes containing game objects
- Use `go.property()` for editor-exposed properties
- Communicate between scripts with `msg.post(target, message_id, data)`
- Spawn at runtime with Factory components: `factory.create(url, pos, rot, props)`
- Input: acquire focus with `msg.post(".", "acquire_input_focus")` then handle in `on_input()`
- Use `hash("action_name")` when comparing input action IDs
- Physics: built-in 2D physics or kinematic collision with `go.set_position()`
- All file references use URL format: `/main/player#sprite`
