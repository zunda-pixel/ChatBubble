// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ChatBubble",
  platforms: [.iOS(.v15), .macOS(.v12), .tvOS(.v15), .watchOS(.v8), .macCatalyst(.v15)],
  products: [
    .library(
      name: "ChatBubble",
      targets: ["ChatBubble"]
    ),
  ],
  targets: [
    .target(
      name: "ChatBubble"
    ),
  ]
)
