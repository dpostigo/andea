// swift-tools-version:3.0
import PackageDescription

let package = Package(
    name: "AndeaSwift",
	dependencies: [
		.package(url: "https://github.com/vapor/core.git", .upToNextMajor(from: "2.1.2"))
	]
    targets: [
        Target(name: "AndeaSwift", dependencies: ["libc"]),
        Target(name: "libc")
    ]
)
