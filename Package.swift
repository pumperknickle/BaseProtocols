// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Bedrock",
    products: [
        .library(
            name: "Bedrock",
            targets: ["Bedrock"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "3.1.2"),
        .package(url: "https://github.com/Quick/Nimble.git", from: "9.0.0"),
    ],
    targets: [
        .target(
            name: "Bedrock",
            dependencies: []),
        .testTarget(
            name: "BedrockTests",
            dependencies: ["Bedrock", "Quick", "Nimble"]),
    ]
)
