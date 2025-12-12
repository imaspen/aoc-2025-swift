import Foundation
import Utils

public struct Day12: Day {
	public init() {}

	public func part1(input: String) async -> String {
		let (shapes, regions) = parse(from: input)
		let results =
			regions
			.reduce(
				into: [Region.Result: [Region]](
					dictionaryLiteral: (.valid, []), (.invalid, []), (.needsPacking, []),
				)
			) { acc, region in
				let result = Region.Result(from: region, with: shapes)
				acc[result]!.append(region)
			}

		guard results[.needsPacking]?.isEmpty ?? true else {
			fatalError("Input isn't fully solved by heuristics")
		}

		return (results[.valid]?.count ?? 0).description
	}

	public func part2(input: String) async -> String {
		"Merry Christmas! 🎄"
	}
}

struct Shape {
	let packedArea: Int

	init(from input: some StringProtocol) {
		self.packedArea = input.count { $0 == "#" }
	}
}

struct Region {
	let w, h: Int
	let counts: [Int]

	init(from input: some StringProtocol) {
		let parts =
			input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.components(separatedBy: ": ")
		let sizeParts = parts[0].split(separator: "x")
		w = Int(sizeParts[0])!
		h = Int(sizeParts[1])!
		counts = parts[1]
			.split(separator: " ")
			.map { Int($0)! }
	}

	func definitelyFits(shapes: [Shape]) -> Bool {
		let presentArea = counts.sum()
		let fittingX = w / 3
		let fittingY = h / 3
		return presentArea <= fittingX * fittingY
	}

	func definitelyDoesNotFit(shapes: [Shape]) -> Bool {
		let presentArea = counts.enumerated().reduce(0) { acc, pair in
			let (index, count) = pair
			return acc + count * shapes[index].packedArea
		}
		let regionArea = w * h
		return presentArea > regionArea
	}

	enum Result {
		case valid
		case invalid
		case needsPacking

		init(from region: Region, with shapes: [Shape]) {
			if region.definitelyFits(shapes: shapes) {
				self = .valid
			} else if region.definitelyDoesNotFit(shapes: shapes) {
				self = .invalid
			} else {
				self = .needsPacking
			}
		}
	}
}

private func parse(from input: String) -> ([Shape], [Region]) {
	let parts = input.components(separatedBy: "\n\n")

	let shapes =
		parts
		.dropLast()
		.map { Shape(from: $0) }

	let regions =
		parts
		.last!
		.trimmingCharacters(in: .whitespacesAndNewlines)
		.split(separator: "\n")
		.map { Region(from: $0) }

	return (shapes, regions)
}
