// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationCenterManager",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "NotificationCenterCore",
            targets: ["NotificationCenterCore"]
        ),
        .executable(
            name: "ncmanager",
            targets: ["NotificationCenterManager"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.1")
    ],
    targets: [
        .target(
            name: "NotificationCenterCore",
            dependencies: []
        ),
        .executableTarget(
            name: "NotificationCenterManager",
            dependencies: [
                "NotificationCenterCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "NotificationCenterCoreTests",
            dependencies: ["NotificationCenterCore"]
        ),
        .testTarget(
            name: "NotificationCenterManagerTests",
            dependencies: ["NotificationCenterManager"]
        )
    ]
)
