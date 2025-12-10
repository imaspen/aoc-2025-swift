import Foundation
import Testing

import struct Day10.Day10

@Suite struct Day10Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day10.txt"))
	let day = Day10()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "7")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "")
	}
}
