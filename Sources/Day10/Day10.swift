import Foundation
import SwiftZ3
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
		return
			Machine.parseAll(from: input)
			.reduce(0) { $0 + $1.solveJoltages() }
			.description
	}
}

class Machine {
	private let lights: Lights
	private let joltages: Joltages
	private let buttons: [Button]

	init(from string: some StringProtocol) {
		let parts = string.split(separator: " ")
		self.lights = Lights(from: parts.first!)
		self.joltages = Joltages(fromJoltages: parts.last!)
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

	func solveJoltages() -> Int {
		let context = Z3Context()
		let solver = context.makeOptimize()

		var joltages = self.joltages.map { _ in context.makeInteger(0) }
		var total = context.makeInteger(0)

		for (index, button) in buttons.enumerated() {
			let buttonPresses = context.makeConstant(
				name: "button_\(index)_presses", sort: IntSort.self
			)

			joltages = joltages.enumerated().map { i, joltage in
				guard button.contains(i) else { return joltage }
				return joltage + buttonPresses
			}

			total = total + buttonPresses
			solver.assert(buttonPresses >= context.makeInteger(0))
		}

		for (joltage, target) in zip(joltages, self.joltages) {
			solver.assert(joltage == context.makeInteger(Int32(target)))
		}

		_ = solver.minimize(total)
		precondition(solver.check() == .satisfiable)
		return Int(solver.getModel().int(total))
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
