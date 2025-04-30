// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "change-language",
    dependencies: [
          .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        ],
    targets: [
        .executableTarget(
            name: "change-language",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources"),
    ]
)
