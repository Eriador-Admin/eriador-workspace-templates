# {{APP_NAME}} — Agent Reference

## Quick Reference

| Item        | Detail                          |
| ----------- | ------------------------------- |
| Framework   | Flutter 3.x                     |
| Language    | Dart                            |
| UI System   | Material Design 3               |
| Platforms   | Android, iOS                    |

## Project Structure

```
├── lib/
│   ├── main.dart                  # App entry point & MaterialApp
│   └── screens/
│       └── home_screen.dart       # Home screen widget
├── pubspec.yaml                   # Dependencies & Flutter config
├── analysis_options.yaml          # Dart linter rules
├── init.sh                        # Setup script
├── run.sh                         # Launch app
├── stop.sh                        # Stop guidance
├── .env.example                   # Environment template
└── .gitignore
```

## Scripts

| Script    | Purpose                                              |
| --------- | ---------------------------------------------------- |
| `init.sh` | Check Flutter, install deps (`pub get`), copy `.env` |
| `run.sh`  | List devices and launch with `flutter run`           |
| `stop.sh` | Guidance on stopping the running app                 |

## Environment Variables

| Variable   | Default                 | Description        |
| ---------- | ----------------------- | ------------------ |
| `API_URL`  | `http://localhost:3000` | Backend API URL    |

## Common Commands

```bash
# Get dependencies
flutter pub get

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run on Chrome (web)
flutter run -d chrome

# Build APK (Android)
flutter build apk

# Build iOS
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format lib/
```

## Adding a New Screen

1. Create a new file in `lib/screens/`:
   ```dart
   import 'package:flutter/material.dart';

   class NewScreen extends StatelessWidget {
     const NewScreen({super.key});

     @override
     Widget build(BuildContext context) {
       return Scaffold(
         appBar: AppBar(title: const Text('New Screen')),
         body: const Center(child: Text('Hello')),
       );
     }
   }
   ```
2. Navigate to it from another screen using `Navigator.push()`.

## Build & Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (Play Store)
flutter build appbundle

# iOS (requires macOS + Xcode)
flutter build ios --release
```
