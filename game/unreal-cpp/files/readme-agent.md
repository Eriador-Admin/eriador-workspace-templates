# Agent Instructions — {{PROJECT_NAME}}

This is an Unreal Engine 5 project with C++ gameplay classes.

## Tech Stack
- **Engine**: Unreal Engine 5.3+
- **Language**: C++ (C++17) + Blueprints
- **Build**: Unreal Build Tool (UBT)

## Key Conventions
- Source code in `Source/{{PROJECT_NAME}}/`
- Every gameplay class uses `UCLASS()` macro + `GENERATED_BODY()`
- Header must include `ClassName.generated.h` as LAST include
- Naming: `A` prefix = Actor, `U` = UObject, `F` = struct, `E` = enum, `I` = interface
- `UPROPERTY(EditAnywhere, BlueprintReadWrite)` for editor-exposed properties
- `UFUNCTION(BlueprintCallable, Category="MyCategory")` for BP-callable functions
- `.Build.cs` defines module dependencies (like a CMakeLists)
- Config in `Config/Default*.ini`
- Content (levels, blueprints, assets) in `Content/`
- Do NOT edit files in `Intermediate/`, `Saved/`, `Binaries/` — auto-generated
- Use `UE_LOG(LogTemp, Warning, TEXT("msg"))` for logging
- Compile from editor: Ctrl+Alt+F11, or Live Coding (Ctrl+Alt+F11)
