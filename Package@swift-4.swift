// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Andea",
    products: [
        .library(name: "libc", targets: ["libc"]),
        .library(name: "Andea", targets: ["Andea"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "libc"),
        .target(name: "Andea", dependencies: ["libc"]),
    ]
)
