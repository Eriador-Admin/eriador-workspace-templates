# {{PROJECT_NAME}}

A 2D game built with [Pygame](https://www.pygame.org/). Features a game loop with sprite management, keyboard input, collision detection, and a simple scoring system.

## Getting Started

```bash
bash init.sh    # create venv + install pygame
bash run.sh     # run the game
bash stop.sh    # stop (Ctrl+C or close window)
```

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
main.py              # Entry point + game loop
src/
  game.py            # Game class (init, update, draw, events)
  player.py          # Player sprite with movement + shooting
  enemy.py           # Enemy sprite with basic AI
  bullet.py          # Bullet sprite
  settings.py        # Constants (screen size, colors, speeds)
assets/              # Sprites, sounds, fonts (placeholder directory)
requirements.txt     # Python dependencies
```

## Requirements

- Python >= 3.9
- pip
