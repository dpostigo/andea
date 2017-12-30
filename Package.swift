// swift-tools-version:4.0
import PackageDescription

let package = Package(
	name: "Andea",
	products: [
//		.library(name: "Andea", targets: ["Andea"]),
//		.library(name: "AndeaBits", targets: ["AndeaBits"]),
	],
	dependencies: [
		.package(url: "https://github.com/alamofire/alamofire.git", from: "4.6.0"),
	],
	targets: [
		.target(
			name: "AndeaSwift"
		),
		.target(
			name: "AndeaBits"
		)
	]
)

