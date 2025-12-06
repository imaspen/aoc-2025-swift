import Foundation
import Testing

import struct Day06.Day06

@Suite struct Day06Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day06.txt"))
	let day = Day06()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "4277556")
	}

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "3263827")
	}
}
