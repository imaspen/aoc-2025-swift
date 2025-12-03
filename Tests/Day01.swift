import Foundation
import Testing

import struct Day01.Day01

@Suite struct Day01Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day01.txt"))
	let day = Day01()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "3")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "6")
	}

	@Test func part2Overflow() async throws {
		let result = await day.part2(input: "R500")
		#expect(result == "5")
	}
}
