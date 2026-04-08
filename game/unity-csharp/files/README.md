# {{PROJECT_NAME}}

A [Unity](https://unity.com/) game project with C# scripts, organized folder structure, and starter scene.

## Prerequisites

- [Unity Hub](https://unity.com/download) installed
- Unity **2022.3 LTS** or later (install via Unity Hub)

## Getting Started

```bash
bash init.sh    # opens the project in Unity Editor
bash run.sh     # builds and runs a standalone player
bash stop.sh    # no-op (Unity manages its own processes)
```

Or open the project directly in Unity Hub by adding the project folder.

## Project Structure

```
Assets/
  Scenes/
    MainScene.unity.meta     # Starter scene (create in Unity Editor)
  Scripts/
    GameManager.cs           # Singleton game manager
    PlayerController.cs      # Basic player movement (WASD/arrows)
    CameraFollow.cs          # Smooth camera follow
  Prefabs/                   # Reusable game objects
  Materials/                 # Materials and shaders
  Textures/                  # Sprite sheets, textures
  Audio/                     # Sound effects and music
  UI/                        # UI prefabs and canvases
  Editor/                    # Custom editor scripts
ProjectSettings/             # Unity project settings
Packages/
  manifest.json              # Unity Package Manager dependencies
```

## C# Conventions

- One MonoBehaviour per file, filename matches class name
- Use `[SerializeField]` for inspector-exposed private fields
- Use `[RequireComponent]` to enforce component dependencies
- Prefer composition over inheritance
- Use assembly definitions (`.asmdef`) for large projects

## Useful Unity Shortcuts

| Shortcut | Action |
|----------|--------|
| Ctrl+S | Save scene |
| Ctrl+P | Play/stop |
| Ctrl+Shift+B | Build settings |
| F | Focus selected object |

## Build Targets

Unity supports building to: Windows, macOS, Linux, iOS, Android, WebGL, PS5, Xbox, Switch (with appropriate licenses).
