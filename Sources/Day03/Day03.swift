import Foundation
import Utils

public struct Day03: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let result = Bank.parseBanks(from: input).map { $0.getMaxJoltage() }.sum()
		return String(result)
	}

	public func part2(input: String) async -> String {
		let result = Bank.parseBanks(from: input).map {
			$0.getMaxJoltage(length: 12)
		}.sum()
		return String(result)
	}
}

struct Bank {
	private let cells: [Int]

	init(from line: any StringProtocol) {
		self.cells = line.map { Int(String($0))! }
	}

	static func parseBanks(from input: any StringProtocol) -> [Bank] {
		return
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.map { Bank(from: $0) }
	}

	func getMaxJoltage(length: Int = 2) -> Int {
		var joltageIndices = [Int: [Int]]()

		for (i, cell) in cells.enumerated() {
			joltageIndices[cell, default: []].append(i)
		}

		var joltage = 0
		var joltageIndex = -1

		for i in (0..<length).reversed() {
			let lastValidIndex = cells.count - i
			for x in (1...9).reversed() {
				if let pos = joltageIndices[x]?.first(where: {
					$0 > joltageIndex && $0 < lastValidIndex
				}) {
					joltage *= 10
					joltage += x
					joltageIndex = pos
					break
				}
			}
		}

		return joltage
	}
}
