import PackageDescription

let package = Package(
        name: "Andea",
        targets: [
                Target(name: "Andea"),
                Target(name: "AndeaExtras", dependencies: ["Andea"])
        ],
        dependencies: [
                .Package(url: "https://github.com/utahiosmac/Marshal.git", majorVersion: 1, minor: 2),
//                .Package(url: "https://github.com/apple/swift-package-manager.git", majorVersion: 3, minor: 1)
        ],
        exclude: ['Sources/Andea/AndeaUIKit']
)

