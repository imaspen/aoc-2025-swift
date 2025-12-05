import Foundation
import Testing

import struct Day05.Day05

@Suite struct Day05Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day05.txt"))
	let day = Day05()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "3")
	}
}
