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
		let points = Point.parsePoints(from: input)
		let perimeter = Line.all(from: points)

		return
			points
			.enumerated()
			.flatMap { i, pointA in
				points[(i + 1)...].map { Rect(pointA, $0) }
			}
			.filter { $0.isWithin(perimeter: perimeter) }
			.max { $0.area < $1.area }!
			.area
			.description
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

struct Rect {
	let a, b: Point
	let area: Int
	let xRange, yRange: ClosedRange<Int>

	init(_ a: Point, _ b: Point) {
		self.a = a
		self.b = b

		self.area = a.area(with: b)

		self.xRange = min(a.x, b.x)...max(a.x, b.x)
		self.yRange = min(a.y, b.y)...max(a.y, b.y)
	}

	func isWithin(perimeter: [Line]) -> Bool {
		for edge in perimeter {
			switch edge {
			case .vertical(let x, let ys):
				if xRange.contains(opened: x), yRange.overlaps(opened: ys) {
					return false
				}
			case .horizontal(let xs, let y):
				if yRange.contains(opened: y), xRange.overlaps(opened: xs) {
					return false
				}
			}
		}

		return true
	}
}

extension ClosedRange where Bound == Int {
	func contains(opened value: Int) -> Bool {
		lowerBound < value && value < upperBound
	}
	func overlaps(opened other: ClosedRange<Int>) -> Bool {
		Swift.max(lowerBound, other.lowerBound)
			< Swift.min(upperBound, other.upperBound)
	}
}

enum Line {
	case horizontal(xs: ClosedRange<Int>, y: Int)
	case vertical(x: Int, ys: ClosedRange<Int>)

	init(from: Point, to: Point) {
		let xs = min(from.x, to.x)...max(from.x, to.x)
		let ys = min(from.y, to.y)...max(from.y, to.y)
		if xs.count == 1 {
			self = .vertical(x: from.x, ys: ys)
		} else {
			self = .horizontal(xs: xs, y: from.y)
		}
	}

	static func all(from points: [Point]) -> [Line] {
		var lines: [Line] = []
		for i in 0..<points.count {
			let pointA = points[i]
			let pointB = points.after(index: i) ?? points.first!
			lines.append(Line(from: pointA, to: pointB))
		}
		return lines
	}
}
