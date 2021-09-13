// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Images",
    platforms: [
        .macOS(.v10_13), .iOS(.v12), .tvOS(.v12), .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Images",
            targets: ["Images"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/Logger.git", from: "1.0.0"),
        .package(url: "https://github.com/elegantchaos/ThreadExtensions.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Images",
            dependencies: ["Logger", "ThreadExtensions"]),
        .testTarget(
            name: "ImagesTests",
            dependencies: ["Images"]),
    ]
)
