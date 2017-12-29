// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Andea",
    products: [
	    .library(name: "Andea", targets: ["Andea"]),
	    .library(name: "AndeaAlamofire", targets: ["AndeaAlamofire"]),
	    .library(name: "AndeaBits", targets: ["AndeaBits"]),
	    .library(name: "AndeaFoundation", targets: ["AndeaFoundation"])
	    // .library(name: "AndeaKit", targets: ["AndeaKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alamofire/alamofire.git", from: "4.6.0"),
    ],
    targets: [
        .target(
            name: "Andea",
            dependencies: [ ]
        ),
	    .target(
		    name: "AndeaAlamofire",
		    dependencies: ["Andea", "Alamofire"]
	    ),
	    .target(
		    name: "AndeaBits",
		    dependencies: ["Andea"]
	    ),
	    .target(
		    name: "AndeaFoundation",
		    dependencies: ["Andea"]
	    )

    ]
)
