// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "curar",
    dependencies: [
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura.git",
                 .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git",
                 .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git",
                 .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/IBM-Swift/Swift-JWT.git",
                 .upToNextMajor(from: "3.5.0")),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "curar",
            dependencies: ["Kitura" , "HeliumLogger", "CouchDB" , "SwiftJWT"],
            path: "Sources"),
        .testTarget(
            name: "curarTests",
            dependencies: ["curar"]),
    ]
)
