# {{PROJECT_NAME}}

A 2D game built with [LOVE](https://love2d.org/) (aka LÖVE) — a lightweight Lua game framework. Features player movement, enemy spawning, shooting, and collision detection.

## Getting Started

```bash
bash init.sh    # verify love is installed
bash run.sh     # run the game
bash stop.sh    # stop
```

## Prerequisites

- [LOVE 11.5+](https://love2d.org/) installed
  - macOS: `brew install love`
  - Linux: `sudo apt install love`
  - Windows: download from love2d.org

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
main.lua             # Entry point (love.load, love.update, love.draw)
conf.lua             # LOVE configuration (window size, title)
src/
  player.lua         # Player entity
  enemy.lua          # Enemy entity with spawner
  bullet.lua         # Bullet entity
  utils.lua          # Helper functions (collision, distance)
```

## How LOVE Works

LOVE calls three main callbacks:
- `love.load()` — called once at startup
- `love.update(dt)` — called every frame with delta time
- `love.draw()` — called every frame for rendering

All game files are Lua modules required from `main.lua`.

## Distribution

```bash
# Create a .love file (cross-platform archive)
zip -9 -r {{PROJECT_NAME}}.love . -x "*.git*" "*.sh" "*.md"
```
