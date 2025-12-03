import Foundation
import Utils

public struct Day02: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let ranges = ClosedRange<Int>.parseList(from: input)
		let invalid = ranges.map { range in
			range.filter { !checkValidity(of: $0) }.sum()
		}.sum()
		return String(invalid)
	}

	public func part2(input: String) async -> String {
		let ranges = ClosedRange<Int>.parseList(from: input)
		let invalid = ranges.map { range in
			let x = range.filter { !checkValidity2(of: $0) }
			return x.sum()
		}.sum()
		return String(invalid)
	}

	private func checkValidity(of value: Int) -> Bool {
		let base = (floor(log10(Double(value))) + 1.0) / 2.0
		if floor(base) != base {
			return true
		}

		let divisor = Int(pow(10.0, base))

		let firstHalf = value / divisor
		let secondHalf = value % divisor

		return firstHalf != secondHalf
	}

	private func checkValidity2(of value: Int) -> Bool {
		let len = Int(floor(log10(Double(value)))) + 1
		let maxSubLen = len / 2

		if maxSubLen == 0 {
			return true
		}

		for i in 1...maxSubLen {
			// skip checking lengths that don't divide evenly
			if (len % i) != 0 {
				continue
			}

			let divisor = Int(pow(10.0, Double(i)))
			let firstPart = value % divisor
			var rest = value / divisor

			while rest > 0, (rest % divisor) == firstPart {
				rest /= divisor
			}

			if rest == 0 {
				return false
			}
		}

		return true
	}
}

extension ClosedRange where Bound == Int {
	fileprivate init(from string: any StringProtocol) {
		let parts = string.split(separator: "-").map { Int($0)! }
		self = parts[0]...parts[1]
	}

	fileprivate static func parseList(from string: any StringProtocol) -> [Self] {
		return
			string
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: ",")
			.map { Self(from: $0) }
	}
}
