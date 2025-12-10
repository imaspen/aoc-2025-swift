import Foundation
import Utils

public struct Day10: Day {
	public init() {}

	public func part1(input: String) async -> String {
		return
			Machine.parseAll(from: input)
			.reduce(0) { $0 + $1.solve() }
			.description
	}

	public func part2(input: String) async -> String {
		return ""
	}
}

class Machine {
	private let lights: Lights
	private let buttons: [Button]

	init(from string: some StringProtocol) {
		let parts = string.split(separator: " ")
		self.lights = Lights(from: parts.first!)
		self.buttons = parts.dropFirst().dropLast().map { Button(fromButton: $0) }
	}

	static func parseAll(from input: some StringProtocol) -> [Machine] {
		input
			.trimmingCharacters(in: .whitespacesAndNewlines)
			.split(separator: "\n")
			.map { Machine(from: String($0)) }
	}

	private var solveCache: [Lights: Int] = [:]
	func solve() -> Int {
		var queue = [
			(
				newState: Array(repeating: false, count: lights.count),
				steps: 0
			)
		]

		while let (state, steps) = queue.popLast() {
			if let previousPath = solveCache[state], steps >= previousPath {
				continue
			}

			solveCache[state] = steps

			if zip(state, lights).allSatisfy({ $0 == $1 }) {
				continue
			}

			queue.append(
				contentsOf: buttons.map {
					(newState: $0.toggle(lights: state), steps: steps + 1)
				}
			)
			queue.sort { $0.steps > $1.steps }
		}

		return solveCache[lights]!
	}
}

typealias Lights = [Bool]
extension Lights {
	init(from string: some StringProtocol) {
		self =
			string
			.dropFirst()
			.dropLast()
			.map { $0 == "#" }
	}
}

typealias Joltages = [Int]
extension Joltages {
	init(fromJoltages string: some StringProtocol) {
		self =
			string
			.dropFirst()
			.dropLast()
			.split(separator: ",")
			.map { Int($0)! }
	}
}

typealias Button = [Int]
extension Button {
	init(fromButton string: some StringProtocol) {
		self =
			string
			.dropFirst()
			.dropLast()
			.split(separator: ",")
			.map { Int($0)! }
	}

	func toggle(lights: Lights) -> Lights {
		var lights = lights
		for index in self {
			lights[index].toggle()
		}
		return lights
	}
}
