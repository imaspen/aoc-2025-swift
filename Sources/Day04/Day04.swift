import Foundation
import Utils

public struct Day04: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return String(Grid(from: input).getAccessible().count)
	}

	public func part2(input: String) async -> String {
		return String(Grid(from: input).getAllAccessible().count)
	}
}

struct Coord: Hashable {
	let x: Int
	let y: Int

	init(_ x: Int, _ y: Int) {
		self.x = x
		self.y = y
	}

	func adjacencies() -> Set<Coord> {
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

typealias Grid = Set<Coord>

extension Grid {
	init(from input: String) {
		self.init()

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
					self.insert(Coord(x, y))
				}
			}
		}
	}

	func getAccessible() -> Grid {
		return self.filter { adjacencies(of: $0).count < 4 }
	}

	func getAllAccessible() -> Grid {
		let iterator = AccessibilityIterator(grid: self)
		var accessed = Grid()

		for accessible in iterator {
			accessed.formUnion(accessible)
		}

		return accessed
	}

	func adjacencies(of coord: Coord) -> [Coord] {
		return coord.adjacencies().filter { self.contains($0) }
	}

	private struct AccessibilityIterator: Sequence, IteratorProtocol {
		var grid: Grid

		mutating func next() -> Set<Coord>? {
			let accessible = grid.getAccessible()
			guard !accessible.isEmpty else {
				return nil
			}

			grid.subtract(accessible)
			return accessible
		}
	}
}
