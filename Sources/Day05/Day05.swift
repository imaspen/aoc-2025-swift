import Foundation
import Utils

public struct Day05: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let (ingredients, freshRanges) = parseInput(input)
		return
			ingredients
			.filter { $0.isFresh(by: freshRanges) }
			.count
			.description
	}

	public func part2(input: String) async -> String {
		var (_, nextRanges) = parseInput(input)
		var freshRanges = [FreshRange]()

		while nextRanges.count != freshRanges.count {
			freshRanges = nextRanges
			nextRanges.removeAll()

			rangeLoop: for range in freshRanges {
				for (i, other) in nextRanges.enumerated() {
					if other.contains(range) {
						continue rangeLoop
					} else if other.overlaps(range) {
						nextRanges[i].merge(with: range)
						continue rangeLoop
					}
				}
				nextRanges.append(range)
			}
		}

		return
			freshRanges
			.map { $0.count }
			.sum()
			.description
	}
}

func parseInput(_ input: String) -> ([Ingredient], [FreshRange]) {
	let sections =
		input
		.trimmingCharacters(in: .whitespacesAndNewlines)
		.components(separatedBy: "\n\n")

	let freshRanges = FreshRange.parseFreshRanges(from: sections[0])
	let ingredients = Ingredient.parseList(from: sections[1])

	return (ingredients, freshRanges)
}

typealias Ingredient = Int

extension Ingredient {
	static func parseList(from input: String) -> [Self] {
		input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.map { Int($0)! }
	}

	func isFresh(by ranges: [FreshRange]) -> Bool {
		for range in ranges {
			if range.contains(self) {
				return true
			}
		}
		return false
	}
}

typealias FreshRange = ClosedRange<Ingredient>

extension FreshRange {
	static func parseFreshRanges(from input: String) -> [Self] {
		input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.map { line in
				let parts = line.split(separator: "-").map { Int($0)! }
				return Self(uncheckedBounds: (lower: parts[0], upper: parts[1]))
			}
	}

	mutating func merge(with other: Self) {
		let lowerBound = Swift.min(lowerBound, other.lowerBound)
		let upperBound = Swift.max(upperBound, other.upperBound)
		self = lowerBound...upperBound
	}
}
