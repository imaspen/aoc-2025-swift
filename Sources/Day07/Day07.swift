import Foundation
import Utils

public struct Day07: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let (startPosition, splitters, height) = Coord.parse(input: input)
		let startY = startPosition.y + 1
		var beams = Set([startPosition.x])
		var total = 0

		for y in startY..<height {
			var nextBeams = Set<Int>()
			for x in beams {
				if splitters.contains(Coord(x: x, y: y)) {
					total += 1
					nextBeams.insert(x - 1)
					nextBeams.insert(x + 1)
				} else {
					nextBeams.insert(x)
				}
			}
			beams = nextBeams
		}

		return total.description
	}

	public func part2(input: String) async -> String {
		let (startPosition, splitters, height) = Coord.parse(input: input)
		var solver = Solver(splitters: splitters, height: height)
		let total = solver.solve(for: startPosition)
		return total.description
	}
}

struct Coord: Hashable {
	let x, y: Int

	static func parse(input: String) -> (
		position: Coord, splitters: Set<Coord>, height: Int
	) {
		let lines =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")

		var startPosition = Coord(x: 0, y: 0)
		var splitters = Set<Coord>()

		for (y, line) in lines.enumerated() {
			for (x, char) in line.enumerated() {
				if char == "S" {
					startPosition = Coord(x: x, y: y)
				} else if char == "^" {
					splitters.insert(Coord(x: x, y: y))
				}
			}
		}
		return (startPosition, splitters, lines.count)
	}
}

struct Solver {
	let splitters: Set<Coord>
	let height: Int
	private var cache = [Coord: Int]()

	init(splitters: Set<Coord>, height: Int) {
		self.splitters = splitters
		self.height = height
	}

	mutating func solve(for beam: Coord) -> Int {
		return solve(for: beam, timelines: 1)
	}

	private mutating func solve(for beam: Coord, timelines: Int) -> Int {
		if let cached = cache[beam] {
			return cached
		}

		guard beam.y < height else {
			return timelines
		}

		guard splitters.contains(beam) else {
			let result = solve(
				for: Coord(x: beam.x, y: beam.y + 1), timelines: timelines)
			cache[beam] = result
			return result
		}

		let leftTimelines = solve(
			for: Coord(x: beam.x - 1, y: beam.y + 1), timelines: timelines
		)
		let rightTimelines = solve(
			for: Coord(x: beam.x + 1, y: beam.y + 1), timelines: timelines
		)
		let result = leftTimelines + rightTimelines
		cache[beam] = result
		return result
	}
}
