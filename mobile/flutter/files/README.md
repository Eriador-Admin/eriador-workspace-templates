# {{APP_NAME}}

A Flutter mobile application with Material Design 3.

## Getting Started

```bash
# Initialize the project (install deps, check Flutter)
bash init.sh

# Launch the app on a connected device or emulator
bash run.sh
```

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.0
- Android Studio or Xcode (for platform-specific builds)
- A connected device or running emulator

## Project Structure

```
lib/
├── main.dart              # App entry point
└── screens/
    └── home_screen.dart   # Home screen
```

## Useful Commands

```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device_id>

# Build release APK
flutter build apk --release

# Run tests
flutter test
```

## Configuration

Copy `.env.example` to `.env` and update values as needed. See `readme-agent.md` for the full reference.
