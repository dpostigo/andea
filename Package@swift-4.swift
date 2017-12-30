// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "AndeaSwift",
    products: [
        .library(name: "libc", targets: ["libc"]),
        .library(name: "AndeaSwift", targets: ["AndeaSwift"]),
    ],
    targets: [
        .target(name: "libc"),
        .target(name: "AndeaSwift", dependencies: ["libc"]),
    ]
)
