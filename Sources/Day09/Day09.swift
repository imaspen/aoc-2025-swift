import Foundation
import Utils

public struct Day09: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let points = Point.parsePoints(from: input)

		return
			points
			.enumerated()
			.flatMap { i, pointA in
				points[(i + 1)...].map { pointB in
					pointA.area(with: pointB)
				}
			}
			.max()!
			.description
	}

	public func part2(input: String) async -> String {
		return ""
	}
}

struct Point {
	let x, y: Int

	init(from string: some StringProtocol) {
		let parts = string.split(separator: ",").map { Int($0)! }
		x = parts[0]
		y = parts[1]
	}

	static func parsePoints(from input: String) -> [Point] {
		return
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.map { Point(from: $0) }
	}

	func area(with other: Point) -> Int {
		return (abs(x - other.x) + 1) * (abs(y - other.y) + 1)
	}
}
