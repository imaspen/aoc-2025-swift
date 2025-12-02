// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser

@main
struct AoC25: ParsableCommand {
	@Option(name: .shortAndLong, help: "The day to run (1-12)")
	var day: Int

	@Option(name: .shortAndLong, help: "The part to run (1-2)")
	var part: Int

	mutating func run() throws {
		print("Hello, world!")
	}
}
