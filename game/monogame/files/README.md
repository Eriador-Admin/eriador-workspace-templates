# {{PROJECT_NAME}}

A cross-platform game built with [MonoGame](https://monogame.net/) — the open-source successor to Microsoft XNA. Games like Celeste, Stardew Valley, and Terraria use MonoGame.

## Getting Started

```bash
bash init.sh    # install MonoGame templates + restore
bash run.sh     # build and run
bash stop.sh    # stop
```

## Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download) or later
- MonoGame templates (installed by init.sh)

## Controls

| Key | Action |
|-----|--------|
| WASD / Arrows | Move player |
| Space | Shoot |
| Escape | Quit |

## Project Structure

```
Game1.cs              # Main game class (Initialize, LoadContent, Update, Draw)
Player.cs             # Player entity with movement + shooting
Enemy.cs              # Enemy entity
Bullet.cs             # Bullet entity
Content/
  Content.mgcb        # MonoGame Content Builder pipeline config
{{PROJECT_NAME}}.csproj    # .NET project file
```

## Game Loop

MonoGame uses XNA's fixed-timestep game loop:
- `Initialize()` — one-time setup
- `LoadContent()` — load textures, sounds, fonts
- `Update(GameTime)` — game logic (60 FPS default)
- `Draw(GameTime)` — rendering

## Content Pipeline

MonoGame uses MGCB (MonoGame Content Builder) to process assets:
```bash
dotnet mgcb Content/Content.mgcb    # process content
```

Or use the MGCB Editor GUI:
```bash
dotnet tool install -g dotnet-mgcb-editor
mgcb-editor Content/Content.mgcb
```

## Platforms

Desktop (Windows/macOS/Linux), Android, iOS, with platform-specific project templates.
