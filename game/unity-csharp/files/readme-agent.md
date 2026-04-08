# Agent Instructions — {{PROJECT_NAME}}

This is a Unity game project using C#.

## Tech Stack
- **Engine**: Unity 2022.3+ LTS
- **Language**: C# (.NET Standard 2.1)
- **Build**: Unity Editor / CLI batch mode

## Key Conventions
- Scripts go in `Assets/Scripts/`
- Each MonoBehaviour class in its own `.cs` file, name must match filename
- Use `[SerializeField] private` instead of public fields for inspector exposure
- Use `[RequireComponent(typeof(Rigidbody))]` to enforce required components
- Scenes go in `Assets/Scenes/`
- Prefabs go in `Assets/Prefabs/`
- Do not edit files in `Library/`, `Temp/`, or `obj/` — they are auto-generated
- `ProjectSettings/` is version-controlled
- Assembly definitions (`.asmdef`) organize code into compilation units
- Use `UnityEngine.Debug.Log()` for logging, not `Console.WriteLine()`
