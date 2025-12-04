import Foundation
import Testing

import struct Day04.Day04

@Suite struct Day04Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day04.txt"))
	let day = Day04()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "13")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "43")
	}
}
