import Foundation
import Testing

import struct Day09.Day09

@Suite struct Day09Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day09.txt"))
	let day = Day09()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "50")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "")
	}
}
