import Foundation
import Testing

import struct Day11.Day11

@Suite struct Day11Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day11.txt"))
	let day = Day11()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "5")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "")
	}
}
