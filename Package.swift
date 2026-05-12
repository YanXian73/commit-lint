// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "commit-lint",
    platforms: [
        .macOS(.v13)
    ],
    targets: [
        .executableTarget(
            name: "commit-lint",
            dependencies: ["CommitLintCore"]
        ),
        .target(
            name: "CommitLintCore"
        ),
        .testTarget(
            name: "CommitLintCoreTests",
            dependencies: ["CommitLintCore"]
        ),
    ]
)
