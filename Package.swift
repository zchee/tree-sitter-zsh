// swift-tools-version:5.3

import Foundation
import PackageDescription

var sources = ["src/parser.c"]
if FileManager.default.fileExists(atPath: "src/scanner.c") {
    sources.append("src/scanner.c")
}

let package = Package(
    name: "TreeSitterZsh",
    products: [
        .library(name: "TreeSitterZsh", targets: ["TreeSitterZsh"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ChimeHQ/SwiftTreeSitter", from: "0.8.0"),
    ],
    targets: [
        .target(
            name: "TreeSitterZsh",
            dependencies: [],
            path: ".",
            sources: sources,
            resources: [
                .copy("queries")
            ],
            publicHeadersPath: "bindings/swift",
            cSettings: [.headerSearchPath("src")]
        ),
        .testTarget(
            name: "TreeSitterZshTests",
            dependencies: [
                "SwiftTreeSitter",
                "TreeSitterZsh",
            ],
            path: "bindings/swift/TreeSitterZshTests"
        )
    ],
    cLanguageStandard: .c11
)
