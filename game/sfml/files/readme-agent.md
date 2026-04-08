# Agent Instructions — {{PROJECT_NAME}}

This is a 2D game built with SFML in C++17.

## Tech Stack
- **Language**: C++17
- **Library**: SFML 2.6+
- **Build**: CMake 3.16+

## Key Conventions
- Game loop: `while (window.isOpen()) { processEvents(); update(dt); render(); }`
- Use `sf::Clock` for delta time
- Use `sf::RectangleShape` for placeholder graphics (swap for `sf::Sprite` + `sf::Texture` later)
- Input: `sf::Keyboard::isKeyPressed()` for real-time, `sf::Event::KeyPressed` for one-shot
- Collision: `shape.getGlobalBounds().intersects(other.getGlobalBounds())`
- Entities use `sf::Vector2f` for position and velocity
- Assets go in `assets/` — load with relative paths from the executable
- All rendering through `sf::RenderWindow`: `window.clear()` → `window.draw()` → `window.display()`
