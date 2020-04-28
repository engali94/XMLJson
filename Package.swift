// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XMLJson",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .executable(name: "XMLJson", targets: ["XMLJson"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.1")

    ],
    targets: [
        .target(name: "XMLJson", dependencies: ["XMLJsonCore"]),
        .target(name: "XMLJsonCore", dependencies: ["ArgumentParser"]),
        .testTarget(name: "XMLJsonTests",dependencies: ["XMLJson"])
    ]
)
