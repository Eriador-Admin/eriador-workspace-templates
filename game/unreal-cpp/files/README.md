# {{PROJECT_NAME}}

An [Unreal Engine 5](https://www.unrealengine.com/) project with C++ gameplay classes. Includes a game mode, player character with movement, and a basic HUD.

## Prerequisites

- [Unreal Engine 5.3+](https://www.unrealengine.com/en-US/download) installed via Epic Games Launcher
- Visual Studio 2022 (Windows) or Xcode 15+ (macOS) with C++ support
- At least 100 GB free disk space for the engine

## Getting Started

```bash
bash init.sh    # generate project files
bash run.sh     # open in Unreal Editor
bash stop.sh    # no-op (editor manages itself)
```

Or open the `.uproject` file directly from Epic Games Launcher.

## Project Structure

```
Source/
  {{PROJECT_NAME}}/
    {{PROJECT_NAME}}.Build.cs           # Module build config
    {{PROJECT_NAME}}GameMode.h / .cpp   # Game mode (spawns player, sets HUD)
    {{PROJECT_NAME}}Character.h / .cpp  # Player character (movement, camera)
    {{PROJECT_NAME}}HUD.h / .cpp        # Basic HUD drawing
{{PROJECT_NAME}}.uproject               # Unreal project descriptor
Config/
  DefaultEngine.ini                     # Engine settings
  DefaultGame.ini                       # Game settings
  DefaultInput.ini                      # Input mappings
Content/                                # Blueprints, assets, levels
```

## C++ Conventions in Unreal

- Classes prefixed per UE convention: `A` (Actor), `U` (UObject), `F` (struct), `E` (enum)
- Use `UCLASS()`, `UPROPERTY()`, `UFUNCTION()` macros for reflection
- Use `GENERATED_BODY()` in every reflected class
- `UPROPERTY(EditAnywhere)` exposes to Blueprint editor
- `UFUNCTION(BlueprintCallable)` allows calling from Blueprints
- Include header: `#include "ClassName.generated.h"` (must be last include)

## Useful Commands

```bash
# Generate Visual Studio / Xcode project files
# (macOS)
/Users/Shared/Epic\ Games/UE_5.3/Engine/Build/BatchFiles/Mac/GenerateProjectFiles.sh $(pwd)/{{PROJECT_NAME}}.uproject

# Build from command line
UnrealBuildTool {{PROJECT_NAME}}Editor Development Mac

# Package for shipping
RunUAT BuildCookRun -project=$(pwd)/{{PROJECT_NAME}}.uproject -platform=Mac -configuration=Shipping
```

## Build Targets

Unreal supports: Windows, macOS, Linux, PS5, Xbox Series X|S, Nintendo Switch, iOS, Android.
