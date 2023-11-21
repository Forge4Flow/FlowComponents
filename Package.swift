// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FlowComponents",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FlowComponents",
            targets: ["FlowComponents"]),
    ],
    dependencies: [
        .package(url: "https://github.com/outblock/fcl-swift.git", from: "0.1.2"),
        .package(url: "https://github.com/maoyama/SyntaxHighlight.git", from: "0.2.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FlowComponents",
            dependencies: [
                .product(name: "FCL", package: "fcl-swift"),
                .product(name: "SyntaxHighlight", package: "SyntaxHighlight"),
            ],
            path: "Sources",
            resources: [
                .process("Resources/cadence.tmGrammar.json")
            ]
        ),
        .testTarget(
            name: "FlowComponentsTests",
            dependencies: ["FlowComponents"]),
    ]
)
