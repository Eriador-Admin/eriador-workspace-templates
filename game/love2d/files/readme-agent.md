# Agent Instructions — {{PROJECT_NAME}}

This is a 2D game built with the LOVE (LÖVE) framework in Lua.

## Tech Stack
- **Language**: Lua 5.1 (LuaJIT)
- **Framework**: LOVE 11.5+
- **Pattern**: Callback-driven game loop

## Key Conventions
- Entry point: `main.lua` with `love.load()`, `love.update(dt)`, `love.draw()`
- Config: `conf.lua` for window settings
- Game entities are Lua tables with `:update(dt)` and `:draw()` methods
- Use `love.graphics` for rendering, `love.keyboard` for input
- Use `dt` (delta time) for frame-independent movement
- Assets loaded via `love.graphics.newImage()`, `love.audio.newSource()`
- No classes built-in — use metatables or simple tables
- Collision: AABB check via utility function
- Run with `love .` from the project directory
