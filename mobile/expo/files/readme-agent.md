# Agent Instructions — {{APP_NAME}}

This is an Expo (React Native) mobile application.

## Tech Stack
- **Framework**: Expo SDK 51+ / React Native
- **Language**: TypeScript
- **Navigation**: Expo Router (file-based routing)
- **Styling**: React Native StyleSheet

## Key Conventions
- File-based routing in `app/` directory (Expo Router)
- Tab navigation via `app/(tabs)/` group
- Shared components in `components/`
- Constants (colors, etc.) in `constants/`
- Uses Expo modules for device APIs

## File Patterns
- `app/**/*.tsx` → Routes/screens
- `app/_layout.tsx` → Layout wrappers
- `components/*.tsx` → Reusable components
- `app.json` → Expo configuration
