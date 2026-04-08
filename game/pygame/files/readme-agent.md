# Agent Instructions — {{PROJECT_NAME}}

This is a 2D game built with Pygame (Python).

## Tech Stack
- **Language**: Python 3.9+
- **Framework**: Pygame 2.x
- **Pattern**: Game loop with sprite groups

## Key Conventions
- Entry point: `main.py`
- Game logic in `src/game.py` — init, event handling, update, draw
- Each game entity is a `pygame.sprite.Sprite` subclass
- Use `pygame.sprite.Group` for batch update/draw/collision
- Constants in `src/settings.py` (screen size, FPS, colors)
- Assets go in `assets/` subdirectories (images/, sounds/, fonts/)
- Use `pygame.time.Clock` to cap FPS
- Use `pygame.key.get_pressed()` for continuous input, events for one-shot
- Collision detection via `pygame.sprite.spritecollide()` or `groupcollide()`
