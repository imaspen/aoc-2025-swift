import Foundation
import Utils

public struct Day11: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let devices = Devices(from: input)
		return devices.solve().description
	}

	public func part2(input: String) async -> String {
		""
	}
}

class Devices {
	private let devices: [String: [String]]
	private let start = "you"
	private let end = "out"

	init(from input: some StringProtocol) {
		self.devices =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.reduce(into: [end: [String]()]) { dict, line in
				let parts = line.split(separator: ":")

				dict[String(parts[0])] =
					parts[1]
					.split(separator: " ", omittingEmptySubsequences: true)
					.map { String($0) }
			}
	}

	func solve() -> Int {
		return solve(from: start)
	}

	private var solveCache: [String: Int] = [:]
	private func solve(from id: String) -> Int {
		if id == end { return 1 }
		if let cached = solveCache[id] { return cached }

		let result = devices[id]!.reduce(0) { $0 + solve(from: $1) }
		solveCache[id] = result
		return result
	}
}
