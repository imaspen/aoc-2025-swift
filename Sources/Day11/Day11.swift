import Foundation
import Utils

public struct Day11: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return Devices(from: input)
			.solve(from: "you")
			.description
	}

	public func part2(input: String) async -> String {
		return Devices(from: input)
			.solve(from: "svr", visiting: ["dac", "fft"])
			.description
	}
}

class Devices {
	private let devices: [String: [String]]
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

	func solve(from id: String, visiting: some Sequence<String> = []) -> Int {
		let visited = visiting.reduce(into: [String: Bool]()) { dict, id in
			dict[id] = false
		}

		return solve(from: id, visited: visited)
	}

	private struct CacheKey: Hashable {
		let id: String
		let visited: [String: Bool]
	}
	private var solveCache: [CacheKey: Int] = [:]
	private func solve(from id: String, visited: [String: Bool]) -> Int {
		let key = CacheKey(id: id, visited: visited)

		if id == end { return visited.values.allSatisfy({ $0 }) ? 1 : 0 }
		if let cached = solveCache[key] { return cached }

		var visited = visited
		if visited.keys.contains(id) { visited[id] = true }

		let result = devices[id]!.reduce(0) {
			$0 + solve(from: $1, visited: visited)
		}

		solveCache[key] = result
		return result
	}
}
