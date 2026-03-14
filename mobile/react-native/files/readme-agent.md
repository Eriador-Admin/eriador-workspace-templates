# Agent Reference — React Native (Expo)

## Overview

Cross-platform mobile application built with React Native and Expo. Uses React Navigation for screen navigation and TypeScript for type safety. Runs on iOS, Android, and web via a single codebase. Uses Expo for build tooling, development server, and over-the-air updates.

## Tech Stack

- **React Native 0.74** — Cross-platform mobile UI framework
- **Expo 51** — Build and development toolchain for React Native
- **React Navigation 6** — Screen navigation (native stack navigator)
- **TypeScript** — Type-safe development

## Prerequisites

- Node.js >= 18
- npm (included with Node.js)
- For device testing: Expo Go app on iOS/Android, or an emulator:
  - **Android:** Android Studio with an AVD (Android Virtual Device) configured
  - **iOS:** Xcode with iOS Simulator (macOS only)

## Project Structure

```
package.json              — Dependencies and scripts (start, android, ios, web)
app.json                  — Expo project configuration (name, slug, platforms)
eas.json                  — EAS Build profiles (development, preview, production)
tsconfig.json             — TypeScript configuration
App.tsx                   — Root component: NavigationContainer with stack navigator
screens/HomeScreen.tsx    — Home screen component
screens/DetailScreen.tsx  — Detail screen component
types/navigation.ts       — TypeScript navigation type definitions
.env.example              — Environment variable defaults
init.sh                   — Install dependencies and setup .env
run.sh                    — Start Expo development server
stop.sh                   — Stop Expo development server
```

## Environment Variables

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `EXPO_PUBLIC_API_URL` | No | `http://localhost:3000` | Backend API base URL. Accessible in code via `process.env.EXPO_PUBLIC_API_URL`. Must use `EXPO_PUBLIC_` prefix to be available in the app bundle. |

**Note:** `EXPO_PUBLIC_` prefixed variables are embedded into the app bundle at build time. Do not put secrets in these variables.

## Scripts

| Script | Purpose | Usage |
|--------|---------|-------|
| `init.sh` | Install npm dependencies, copy `.env.example` to `.env` | `bash init.sh` |
| `run.sh` | Start the Expo development server (opens interactive CLI) | `bash run.sh` |
| `stop.sh` | Stop the Expo development server | `bash stop.sh` |

## Running Locally

```bash
bash init.sh
bash run.sh
```

The Expo CLI starts and presents options:
- Press **a** to open in Android Emulator
- Press **i** to open in iOS Simulator (macOS only)
- Press **w** to open in web browser
- Scan the QR code with Expo Go app on a physical device

Platform-specific commands:

```bash
npx expo start --android    # Launch directly on Android
npx expo start --ios        # Launch directly on iOS Simulator
npx expo start --web        # Launch in web browser
```

## Deployment (Expo)

This template does **not** use Docker. Mobile apps are deployed via Expo's build and submission services.

### Development builds (for testing):

```bash
npx expo prebuild           # Generate native iOS/Android projects
npx expo run:android        # Build and run on Android
npx expo run:ios            # Build and run on iOS (macOS only)
```

### Production builds (via EAS Build):

Build profiles are defined in `eas.json`:

| Profile | Purpose | Distribution |
|---------|---------|-------------|
| `development` | Dev client with debugger support | Internal (APK / Simulator build) |
| `preview` | Testable build without dev tools | Internal (APK / Simulator build) |
| `production` | Release build with auto-incrementing version | App Store / Google Play |

```bash
npm install -g eas-cli
eas build --profile development --platform android   # Dev build (APK)
eas build --profile development --platform ios        # Dev build (Simulator)
eas build --profile preview --platform all            # Test build
eas build --profile production --platform all         # Release build
eas submit --platform android
eas submit --platform ios
```

**Note:** For `eas submit`, update the placeholder values in `eas.json` under `submit.production` with your Apple ID / App Store Connect App ID (iOS) and Google service account key path (Android).

### Web deployment:

```bash
npx expo export --platform web
```

Output goes to `dist/` — serve with any static file server.

## Health Check

The Expo dev server runs on port **8081**. Verify it's running:

```bash
curl -s -o /dev/null -w "%{http_code}" http://localhost:8081/
```

To verify the app itself, check that it loads on the emulator/device and the home screen renders.

## Customization

- **Add screens:** Create new components in `screens/` and add them to the stack navigator in `App.tsx`
- **Add navigation types:** Update `types/navigation.ts` with route params for new screens
- **Add API calls:** Use `process.env.EXPO_PUBLIC_API_URL` as the base URL for fetch calls
- **Add state management:** Install Zustand or Redux Toolkit and create stores
- **Add native modules:** Use `npx expo install <package>` to install Expo-compatible native modules
- **Configure app.json:** Update name, slug, icon, splash screen, and build configuration
