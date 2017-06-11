import PackageDescription

let package = Package(
    name: "andea",
    dependencies: [
        .Package(url: "https://github.com/vapor/core.git", majorVersion: 2, minor: 0)
    ]
)

