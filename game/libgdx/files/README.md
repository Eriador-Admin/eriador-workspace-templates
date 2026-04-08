# {{PROJECT_NAME}}

A cross-platform game built with [libGDX](https://libgdx.com/) — a Java game development framework. Features sprite rendering, input handling, collision detection, and a desktop launcher.

## Getting Started

```bash
bash init.sh    # build with Gradle
bash run.sh     # run the desktop version
bash stop.sh    # stop
```

## Prerequisites

- Java JDK 17+
- Gradle (included via wrapper)

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
core/
  src/com/game/
    MyGame.java           # ApplicationAdapter — main game class
    Player.java           # Player entity
    Enemy.java            # Enemy entity
    Bullet.java           # Bullet entity
    GameScreen.java       # Game screen with update/render
desktop/
  src/com/game/desktop/
    DesktopLauncher.java  # Desktop entry point (LWJGL3)
build.gradle              # Root build config
settings.gradle           # Module definitions
gradle.properties         # libGDX + Gradle settings
```

## Platforms

libGDX supports: Desktop (Windows/macOS/Linux), Android, iOS (via RoboVM), and HTML5 (via GWT). This template includes the desktop module. Add more via the [libGDX setup tool](https://libgdx.com/wiki/start/project-generation).

## Useful Commands

```bash
# Build
./gradlew build

# Run desktop
./gradlew desktop:run

# Clean
./gradlew clean
```
