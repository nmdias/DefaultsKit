// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DefaultsKit",
  products: [
    .library(
      name: "DefaultsKit",
      targets: ["DefaultsKit"]
    ),
  ],
  targets: [
    .target(
      name: "DefaultsKit"
    ),
    .testTarget(
      name: "DefaultsKitTests",
      dependencies: ["DefaultsKit"]
    ),
  ]
)
