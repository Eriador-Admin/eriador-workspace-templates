# {{APP_NAME}}

A cross-platform mobile app built with [Expo](https://expo.dev/) and React Native.

## Getting Started

```bash
bash init.sh    # install dependencies
bash run.sh     # start Expo dev server
bash stop.sh    # stop the dev server
```

## Project Structure

```
app/
  (tabs)/
    index.tsx        # Home tab
    explore.tsx      # Explore tab
    _layout.tsx      # Tab layout
  _layout.tsx        # Root layout
components/          # Reusable components
constants/           # Theme colors, etc.
```

## Running

- **iOS Simulator**: Press `i` in the terminal
- **Android Emulator**: Press `a` in the terminal
- **Physical device**: Scan QR code with Expo Go app

## Requirements

- Node.js 18+
- Expo Go app (for physical device testing)
- Xcode (for iOS simulator) or Android Studio (for Android emulator)
