// swift-tools-version:3.0
import PackageDescription

let package = Package(
    name: "Andea",
    targets: [
        Target(name: "Andea", dependencies: ["libc"]),
        Target(name: "libc")
    ],
    dependencies: [
    ]
)
