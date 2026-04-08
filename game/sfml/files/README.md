# {{PROJECT_NAME}}

A 2D game built with [SFML](https://www.sfml-dev.org/) (Simple and Fast Multimedia Library) — a cross-platform C++ library for window management, 2D graphics, audio, and networking.

## Getting Started

```bash
bash init.sh     # create build directory, run cmake
bash run.sh      # build and run
bash stop.sh     # stop
```

## Prerequisites

- CMake 3.16+
- C++17 compiler (GCC 9+, Clang 10+, MSVC 2019+)
- SFML 2.6+ (installed via system package manager or auto-fetched by CMake)

### Install SFML

**macOS:**
```bash
brew install sfml
```

**Ubuntu/Debian:**
```bash
sudo apt install libsfml-dev
```

**Windows:**
Download from https://www.sfml-dev.org/download.php or use vcpkg.

## Project Structure

```
CMakeLists.txt         # Build configuration with SFML
src/
  main.cpp             # Entry point, game loop
  game.h / game.cpp    # Game class (window, update, render)
  player.h / player.cpp # Player entity
  enemy.h / enemy.cpp   # Enemy entity
  bullet.h / bullet.cpp # Bullet entity
assets/                # Fonts, textures, sounds (placeholder)
```

## Controls

- **WASD / Arrow Keys** — Move player
- **Space** — Shoot
- **Escape** — Quit

## Building Manually

```bash
mkdir -p build && cd build
cmake ..
cmake --build .
./{{PROJECT_NAME}}
```
