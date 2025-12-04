import Foundation
import Utils

public struct Day04: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return String(Grid(from: input).getAccessible().count)
	}

	public func part2(input: String) async -> String {
		return ""
	}
}

struct Coord: Hashable {
	let x: Int
	let y: Int

	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	func adjacencies() -> [Coord] {
		return [
			Coord(x - 1, y - 1),
			Coord(x - 1, y),
			Coord(x - 1, y + 1),

			Coord(x, y - 1),
			Coord(x, y + 1),

			Coord(x + 1, y - 1),
			Coord(x + 1, y),
			Coord(x + 1, y + 1),
		]
	}
}

struct Grid {
	var grid: Set<Coord>

	init(from input: String) {
		grid = Set<Coord>()

		let lines =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.enumerated()

		for (y, line) in lines {
			let chars =
				line
				.trimmingCharacters(in: .whitespacesAndNewlines)
				.enumerated()

			for (x, char) in chars {
				if char == "@" {
					grid.insert(Coord(x, y))
				}
			}
		}
	}

	func getAccessible() -> [Coord] {
		grid.filter { adjacencies(of: $0).count < 4 }
	}

	func adjacencies(of coord: Coord) -> [Coord] {
		return coord.adjacencies().filter { grid.contains($0) }
	}
}
