import Foundation
import Utils

public struct Day03: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let result = Bank.parseBanks(from: input).map { $0.getMaxJoltage() }.sum()
		return String(result)
	}

	public func part2(input: String) async -> String {
		return ""
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

	func getMaxJoltage() -> Int {
		var joltageIndices = [Int: [Int]]()
		let lastIndex = cells.count - 1

		for (i, cell) in cells.enumerated() {
			joltageIndices[cell, default: []].append(i)
		}

		var joltage = 0

		var joltageStartIndex = 0
		for i in (1...9).reversed() {
			if let pos = joltageIndices[i]?.first, pos < lastIndex {
				joltage = i * 10
				joltageStartIndex = pos
				break
			}
		}

		for i in (1...9).reversed() {
			if let pos = joltageIndices[i]?.last, pos > joltageStartIndex {
				joltage += i
				break
			}
		}

		return joltage
	}
}
