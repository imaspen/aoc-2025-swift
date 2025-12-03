import Foundation
import Testing

import struct Day01.Day01

@Suite struct Day01Tests {
	@Test func part1() async throws {
		let url = URL(fileURLWithPath: "./res/test/Day01.txt")
		let contents = try String(contentsOf: url)
		let day = Day01()
		let result = await day.part1(input: contents)
		#expect(result == "3")
	}
}
