# Agent Instructions — {{PROJECT_NAME}}

This is a 2D game built with raylib in C.

## Tech Stack
- **Language**: C (C99)
- **Library**: raylib 5.x
- **Build**: CMake

## Key Conventions
- Entry point: `src/main.c`
- Game loop pattern: `InitWindow` → while `!WindowShouldClose()` → `BeginDrawing/EndDrawing` → `CloseWindow`
- Use `IsKeyDown()` for continuous input, `IsKeyPressed()` for one-shot
- Drawing between `BeginDrawing()` and `EndDrawing()`
- Use `GetFrameTime()` for delta time
- `DrawText()`, `DrawRectangle()`, `DrawCircle()` for basic rendering
- Colors: `RED`, `GREEN`, `BLUE`, `WHITE`, `BLACK`, `RAYWHITE` etc.
- Memory: stack-allocate structs when possible, use arrays for entity lists
- No garbage collector — free resources explicitly
- Include with `#include "raylib.h"`
