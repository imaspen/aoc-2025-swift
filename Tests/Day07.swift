import Foundation
import Testing

import struct Day07.Day07

@Suite struct Day07Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day07.txt"))
	let day = Day07()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "21")
	}
}
