// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LocalizedStringsCleaner",
    products: [.executable(name: "localizedcleaner", targets: ["LocalizedStringsCleaner"]),
               .library(name: "LocalizedStringsCleanerCore", targets: ["LocalizedStringsCleanerCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mac-cain13/R.swift.git", from: "3.0.0"),
    ],
    targets: [
      .target(name: "LocalizedStringsCleaner", dependencies: ["LocalizedStringsCleanerCore"]),
      .target(name: "LocalizedStringsCleanerCore", dependencies: ["rswift"])
    ]
)
