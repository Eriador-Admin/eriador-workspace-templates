# {{APP_NAME}}

A native Android application built with [Jetpack Compose](https://developer.android.com/jetpack/compose).

## Getting Started

```bash
bash init.sh    # verify Android SDK and open in Android Studio
bash run.sh     # build the debug APK
bash stop.sh    # stop Gradle daemon
```

## Project Structure

```
app/src/main/
  java/{{PACKAGE_NAME}}/
    MainActivity.kt          # Entry point
    ui/theme/                 # Material 3 theme
    ui/screens/               # Composable screens
    viewmodel/                # ViewModels
    model/                    # Data models
  res/
    values/                   # Strings, colors, themes
```

## Architecture

- **MVVM** with Jetpack Compose
- Material 3 design system
- ViewModel with StateFlow for state management

## Requirements

- Android Studio Hedgehog+
- Android SDK {{MIN_SDK}}+
- JDK 17
