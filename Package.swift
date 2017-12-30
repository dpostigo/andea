// swift-tools-version:4.0
import PackageDescription

let package = Package(
	name: "Andea",
	products: [
		.library(name: "libc", targets: ["libc"]),
		.library(name: "AndeaSwift", targets: ["AndeaSwift"]),
		// .library(name: "AndeaBits", targets: ["AndeaBits"]),
	],
	targets: [
		.target(
			name: "AndeaSwift",
			dependencies: ["libc"],
			path: "Sources/AndeaSwift/"
		),
		.target(
			name: "libc",
			path: "Sources/libc"
		),
//		.target(
//			name: "AndeaBits"
//		)
	]
)

