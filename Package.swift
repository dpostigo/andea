// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Andea",
    products: [
	    .library(name: "Andea", targets: ["Andea"]),
	    .library(name: "AndeaAlamofire", targets: ["AndeaAlamofire"]),
	    .library(name: "AndeaBits", targets: ["AndeaBits"]),
	    .library(name: "AndeaFoundation", targets: ["AndeaFoundation"]),
	    .library(name: "AndeaKit", targets: ["AndeaKit"]),
	    .library(name: "NSAndea", targets: ["NSAndea"]),
    ],
    dependencies: [
        .package(url: "https://github.com/alamofire/alamofire.git", from: "4.6.0"),
    ],
    targets: [
        .target(
            name: "Andea",
	        path: "Sources/Andea"
        ),
	    .target(
		    name: "AndeaAlamofire",
		    dependencies: ["Andea", "Alamofire"],
		    path: "Sources/AndeaAlamofire"
	    ),
	    .target(
		    name: "AndeaBits",
		    dependencies: ["Andea"],
		    path: "Sources/AndeaBits"
	    ),
	    .target(
		    name: "AndeaFoundation",
		    dependencies: ["Andea"],
		    path: "Sources/AndeaFoundation"
	    ),
	    .target(
		    name: "AndeaKit",
		    dependencies: ["Andea"],
		    path: "Sources/AndeaKit"
	    ),
	    .target(
		    name: "NSAndea",
		    path: "Sources/NSAndea"
	    )

    ]
)
