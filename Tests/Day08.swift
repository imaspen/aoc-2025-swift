import Foundation
import Testing

import struct Day08.Day08

@Suite struct Day08Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day08.txt"))
	let day = Day08()

	@Test func part1() async throws {
		let result = await day.part1(input: contents, connectionCount: 10)
		#expect(result == "40")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "")
	}
}
