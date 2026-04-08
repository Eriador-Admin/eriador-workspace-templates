# {{APP_NAME}}

A native iOS application built with [SwiftUI](https://developer.apple.com/swiftui/).

## Getting Started

```bash
bash init.sh    # open the project in Xcode
bash run.sh     # build and run in simulator
bash stop.sh    # stop the simulator
```

## Project Structure

```
{{APP_NAME}}/
  {{APP_NAME}}App.swift     # App entry point
  ContentView.swift          # Main view
  Views/                     # SwiftUI views
  ViewModels/                # MVVM view models
  Models/                    # Data models
  Services/                  # Network/data services
  Assets.xcassets/           # Images and colors
```

## Architecture

- **MVVM** pattern with SwiftUI
- Views observe ViewModels via `@Observable`
- Services layer for networking and persistence

## Requirements

- macOS with Xcode 15+
- iOS {{MIN_IOS_VERSION}}+ deployment target
