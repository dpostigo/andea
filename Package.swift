// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Andea",
    products: [
	    .library(name: "Andea", targets: ["Andea"]),
	    // .library(name: "AndeaKit", targets: ["AndeaKit"]),
	    .library(name: "AndeaLibraries", targets: ["AndeaLibraries"])
    ],
    dependencies: [
	    // .Package(url: "https://github.com/utahiosmac/Marshal.git", majorVersion: 1, minor: 2),
        .package(url: "https://github.com/alamofire/alamofire.git", from: "4.6.0"),
    ],
    targets: [
        .target(
            name: "Andea",
            dependencies: [

            ]
        ),
	    .target(
		    name: "AndeaLibraries",
		    dependencies: [
			    "Andea",
			    "Alamofire"
		    ]
	    )

    ]
)
