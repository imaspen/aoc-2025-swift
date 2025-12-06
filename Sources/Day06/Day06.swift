import Foundation
import Utils

public struct Day06: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return Problem.parseProblems(in: input)
			.map { $0.solve() }
			.sum()
			.description
	}

	public func part2(input: String) async -> String {
		return ""
	}
}

enum Operator: Character {
	case add = "+"
	case multiply = "*"
}

struct Problem {
	let operation: Operator
	let operands: [Int]

	func solve() -> Int {
		switch operation {
		case .add:
			return operands.sum()
		case .multiply:
			return operands.product()
		}
	}

	static func parseProblems(in input: String) -> [Problem] {
		var lines =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")

		let operations =
			lines
			.popLast()!
			.split(separator: " ", omittingEmptySubsequences: true)
			.map { Operator(rawValue: $0.first!) }

		let numbers =
			lines.map { line in
				line
					.split(separator: " ", omittingEmptySubsequences: true)
					.map { Int($0)! }
			}

		return numbers[0].indices.map { i in
			let operands = numbers.map { $0[i] }
			return Problem(operation: operations[i]!, operands: operands)
		}
	}
}
