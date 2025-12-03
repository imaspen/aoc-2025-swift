import Foundation
import Testing

import struct Day03.Day03

@Suite struct Day03Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day03.txt"))
	let day = Day03()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "357")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "3121910778619")
	}
}
