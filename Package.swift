// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "AHDownloadButton",
    platforms: [
        .iOS(.v8),
    ],
    products: [
        .library(name: "AHDownloadButton", targets: ["AHDownloadButton"])
    ],
    targets: [
        .target(
            name: "AHDownloadButton",
            dependencies: []),
    ],
    swiftLanguageVersions: [
        .v5
    ]
    
)
