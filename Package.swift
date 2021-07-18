// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "AHDownloadButton",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        .library(
            name: "AHDownloadButton",
            targets: ["AHDownloadButton"]),
    ],
    targets: [
        .target(
            name: "AHDownloadButton",
            dependencies: [])
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
