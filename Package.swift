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
			url: "https://github.com/apple/swift-argument-parser.git",
			from: "1.2.0"
		),
		.package(
			url: "https://github.com/LuizZak/swift-z3.git",
			branch: "master"
		),
	],
	targets: [
		.executableTarget(
			name: "aoc-2025",
			dependencies: [
				.product(name: "ArgumentParser", package: "swift-argument-parser"),

				"Utils",

				"Day01",
				"Day02",
				"Day03",
				"Day04",
				"Day05",
				"Day06",
				"Day07",
				"Day08",
				"Day09",
				"Day10",
				"Day11",
			],
		),

		.target(name: "Utils"),

		.target(name: "Day01", dependencies: ["Utils"]),
		.target(name: "Day02", dependencies: ["Utils"]),
		.target(name: "Day03", dependencies: ["Utils"]),
		.target(name: "Day04", dependencies: ["Utils"]),
		.target(name: "Day05", dependencies: ["Utils"]),
		.target(name: "Day06", dependencies: ["Utils"]),
		.target(name: "Day07", dependencies: ["Utils"]),
		.target(name: "Day08", dependencies: ["Utils"]),
		.target(name: "Day09", dependencies: ["Utils"]),
		.target(
			name: "Day10",
			dependencies: ["Utils", .product(name: "SwiftZ3", package: "swift-z3")]),
		.target(name: "Day11", dependencies: ["Utils"]),

		.testTarget(
			name: "aoc-2025-tests",
			dependencies: ["aoc-2025"]),
	],
)
