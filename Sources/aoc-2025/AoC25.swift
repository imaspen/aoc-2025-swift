// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation
import Utils

import struct Day01.Day01
import struct Day02.Day02
import struct Day03.Day03
import struct Day04.Day04
import struct Day05.Day05
import struct Day06.Day06
import struct Day07.Day07

enum AoCDay: Int, ExpressibleByArgument {
	init?(argument: String) {
		guard let dayNumber = Int(argument),
			let day = AoCDay(rawValue: dayNumber)
		else {
			return nil
		}

		self = day
	}

	case day1 = 1
	case day2 = 2
	case day3 = 3
	case day4 = 4
	case day5 = 5
	case day6 = 6
	case day7 = 7

	var day: Day {
		switch self {
		case .day1:
			return Day01()
		case .day2:
			return Day02()
		case .day3:
			return Day03()
		case .day4:
			return Day04()
		case .day5:
			return Day05()
		case .day6:
			return Day06()
		case .day7:
			return Day07()
		}
	}

	var string: String {
		return String(format: "%02d", self.rawValue)
	}
}

enum AoCPart: Int, ExpressibleByArgument {
	init?(argument: String) {
		guard let partNumber = Int(argument),
			let part = AoCPart(rawValue: partNumber)
		else {
			return nil
		}

		self = part
	}

	case part1 = 1
	case part2 = 2

	func run(day: Day, input: String) async -> String {
		switch self {
		case .part1:
			return await day.part1(input: input)
		case .part2:
			return await day.part2(input: input)
		}
	}
}

@main
struct AoC25: AsyncParsableCommand {
	static let _commandName = "aoc-2025"

	@Option(name: .shortAndLong, help: "The day to run (1-12)")
	var day: AoCDay

	@Option(name: .shortAndLong, help: "The part to run (1-2)")
	var part: AoCPart

	@Argument(
		help: "The input text, defaults to reading from ./res/input/DayXX.txt")
	var inputFile: String?

	mutating func run() async throws {
		let url = URL(fileURLWithPath: "./res/input/Day\(day.string).txt")
		let contents = try String(contentsOf: url)

		let res = await part.run(day: day.day, input: contents)
		print(res)
	}
}
