# Agent Instructions — {{APP_NAME}}

This is a native Android application using Jetpack Compose.

## Tech Stack
- **Language**: Kotlin
- **UI**: Jetpack Compose with Material 3
- **Architecture**: MVVM
- **Build**: Gradle (Kotlin DSL)

## Key Conventions
- Activities in `MainActivity.kt` — single-activity architecture
- Composable screens in `ui/screens/`
- Theme in `ui/theme/` (Material 3)
- ViewModels in `viewmodel/`
- Data models in `model/`

## File Patterns
- `*.kt` → Kotlin source files
- `build.gradle.kts` → Gradle build config
- `res/values/*.xml` → Resources (strings, colors)
- `AndroidManifest.xml` → App manifest
