// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "aoc-2025",
	platforms: [
		.macOS(.v11)
	],
	dependencies: [
		.package(
			url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0")
	],
	targets: [
		.executableTarget(
			name: "aoc-2025",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),

				"Utils",

				"Day01",
			],
		),

		.target(name: "Day01", dependencies: ["Utils"]),
		.target(name: "Utils"),

		.testTarget(
			name: "aoc-2025-tests",
			dependencies: ["aoc-2025"]),
	],
)
