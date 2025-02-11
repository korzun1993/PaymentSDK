// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "PaymentSDK",
    platforms: [.iOS("17.0")],
    products: [
        .library(
            name: "PaymentSDK",
            targets: ["PaymentSDK"]),
    ],
    targets: [
        .target(
            name: "PaymentSDK"
        ),
        .testTarget(
            name: "PaymentSDKTests",
            dependencies: ["PaymentSDK"]),
    ]
)
