// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "{{APP_NAME}}",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "{{APP_NAME}}", targets: ["{{APP_NAME}}"])
    ],
    targets: [
        .target(name: "{{APP_NAME}}", path: "{{APP_NAME}}"),
        .testTarget(name: "{{APP_NAME}}Tests", dependencies: ["{{APP_NAME}}"], path: "{{APP_NAME}}Tests")
    ]
)
