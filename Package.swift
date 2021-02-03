// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "Images",
    products: [
        .library(
            name: "Images",
            targets: ["Images"]),
    ],
    dependencies: [
        .package(url: "https://github.com/elegantchaos/ThreadExtensions.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "Images",
            dependencies: ["ThreadExtensions"]),
        .testTarget(
            name: "ImagesTests",
            dependencies: ["Images"]),
    ]
)
