// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "BiometryTypeBugWorkaround",
    products: [
        .library(name: "BiometryTypeBugWorkaround", targets: ["BiometryTypeBugWorkaround"])
    ],

    targets: [
        .target(name: "BiometryTypeBugWorkaround", dependencies: [])
    ]
)
