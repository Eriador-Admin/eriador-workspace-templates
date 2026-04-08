# {{PROJECT_NAME}}

A 2D game built with [Defold](https://defold.com/) — King's free game engine. Lightweight, fast, and optimized for mobile and HTML5 games.

## Getting Started

```bash
bash init.sh    # verify Defold / instructions
bash run.sh     # open in Defold editor
bash stop.sh    # no-op
```

Or open `game.project` directly in the Defold editor.

## Prerequisites

- [Defold Editor](https://defold.com/) downloaded

## Project Structure

```
game.project                    # Project settings (display, physics, input)
main/
  main.collection              # Root collection (the scene)
  main.script                  # Main controller script
  player.go                    # Player game object
  player.script                # Player Lua script (movement, shooting)
  enemy.go                     # Enemy game object
  enemy.script                 # Enemy Lua script
  bullet.go                    # Bullet game object  
  bullet.script                # Bullet Lua script
  factory/
    enemy_factory.go           # Factory for spawning enemies
    bullet_factory.go          # Factory for spawning bullets
input/
  game.input_binding           # Input key bindings
```

## Defold Concepts

- **Game Objects (.go)**: Entities with components (sprites, scripts, collision)
- **Collections (.collection)**: Scenes that contain game objects
- **Scripts (.script)**: Lua scripts attached to game objects
- **Factories**: Components that spawn game objects at runtime
- **Messages**: Communication between scripts via `msg.post()`

## Lifecycle Callbacks

```lua
function init(self)     -- called once when script starts
function update(self, dt) -- called every frame
function on_message(self, message_id, message, sender) -- message handler
function on_input(self, action_id, action) -- input handler
function final(self)    -- cleanup
```

## Platforms

Desktop (Windows/macOS/Linux), iOS, Android, HTML5.
