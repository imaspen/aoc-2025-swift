import Foundation
import Testing

import struct Day02.Day02

@Suite struct Day02Tests {
	let contents = try! String(
		contentsOf: URL(fileURLWithPath: "./res/test/Day02.txt"))
	let day = Day02()

	@Test func part1() async throws {
		let result = await day.part1(input: contents)
		#expect(result == "1227775554")
	}
}
