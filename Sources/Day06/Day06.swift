import Foundation
import Utils

public struct Day06: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return Problem.parseProblems(from: input).sumResults().description
	}

	public func part2(input: String) async -> String {
		return Problem.parseCephalopod(from: input).sumResults().description
	}
}

extension Collection where Element == Problem {
	func sumResults() -> Int {
		return self.reduce(0) { $0 + $1.solve() }
	}
}

enum Operator: Character {
	case add = "+"
	case multiply = "*"

	static func withStart(
		start: Int, rawValue: Character
	) -> (start: Int, operation: Self)? {
		switch Self(rawValue: rawValue) {
		case .none: return nil
		case .some(let op): return (start: start, operation: op)
		}
	}
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

	static func parseProblems(from input: String) -> [Problem] {
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

	static func parseCephalopod(from input: String) -> [Problem] {
		var lines =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")

		let indexedOperations =
			lines.popLast()!.enumerated().compactMap {
				Operator.withStart(start: $0.offset, rawValue: $0.element)
			}

		let numberRows = lines.map { $0.map { Int(String($0)) } }

		return indexedOperations.enumerated().map { (i, element) in
			let end =
				switch indexedOperations.after(index: i)?.start {
				case .some(let nextStart): nextStart - 1
				case .none: numberRows[0].count
				}

			let operands = (element.start..<end).map { i in
				numberRows.reduce(0) { acc, row in
					guard let val = row[i] else { return acc }
					return acc * 10 + val
				}
			}

			return Problem(operation: element.operation, operands: operands)
		}
	}
}
