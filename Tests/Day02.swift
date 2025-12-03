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

	@Test func part2() async throws {
		let result = await day.part2(input: contents)
		#expect(result == "4174379265")
	}

	@Test func part2EdgeCase() async throws {
		let edgeCaseInput = "10101-10101"
		let result = await day.part2(input: edgeCaseInput)
		#expect(result == "0")
	}
}
