# Agent Instructions — {{APP_NAME}}

This is a native iOS application using SwiftUI.

## Tech Stack
- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Architecture**: MVVM
- **Build**: Xcode / Swift Package Manager

## Key Conventions
- App entry in `{{APP_NAME}}/{{APP_NAME}}App.swift`
- Views in `Views/` — SwiftUI structs
- ViewModels in `ViewModels/` — `@Observable` classes
- Models in `Models/` — Codable structs
- Services in `Services/` — async/await networking

## File Patterns
- `*.swift` → Swift source files
- `Assets.xcassets/` → Asset catalogs
- `Package.swift` → SPM dependencies (if used)
- `*.xcodeproj` → Xcode project (generated)
