// swift-tools-version:3.0
import PackageDescription

let package = Package(
    name: "AndeaSwift",
    targets: [
        Target(name: "AndeaSwift", dependencies: ["libc"]),
        Target(name: "libc")
    ]
)
