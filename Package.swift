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
    ],
    targets: [
        .target(
            name: "Images",
            dependencies: []),
        .testTarget(
            name: "ImagesTests",
            dependencies: ["Images"]),
    ]
)
