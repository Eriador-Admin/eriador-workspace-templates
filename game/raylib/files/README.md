# {{PROJECT_NAME}}

A 2D game built with [raylib](https://www.raylib.com/) — a simple C library for game programming. Features player movement, enemy spawning, shooting, and collision detection.

## Getting Started

```bash
bash init.sh    # install raylib + build
bash run.sh     # run the game
bash stop.sh    # stop
```

## Prerequisites

- C compiler (gcc/clang)
- CMake >= 3.16
- raylib:
  - macOS: `brew install raylib`
  - Linux: `sudo apt install libraylib-dev` or build from source
  - Windows: download from raylib.com

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
src/
  main.c              # Entry point + game loop
  game.h              # Game state struct + function declarations
  game.c              # Game logic (init, update, draw)
  player.h / .c       # Player entity
  enemy.h / .c        # Enemy entity + spawner
  bullet.h / .c       # Bullet entity
CMakeLists.txt         # Build configuration
```

## Building Manually

```bash
mkdir -p build && cd build
cmake ..
make
./{{PROJECT_NAME}}
```

## Why raylib?

- Pure C, no dependencies beyond system libs
- Simple API (~60 core functions)
- Cross-platform (Windows, macOS, Linux, Android, Web)
- Great for learning game programming fundamentals
