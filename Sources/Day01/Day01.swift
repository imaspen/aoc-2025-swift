import Foundation
import Utils

public struct Day01: Day {
	public init() {}

	enum Direction {
		case left
		case right

		init(from char: Character) {
			switch char {
			case "L":
				self = .left
			case "R":
				self = .right
			default:
				fatalError("Invalid direction character: \(char)")
			}
		}
	}

	struct Instruction {
		let direction: Direction
		let distance: Int

		init(from string: any StringProtocol) {
			self.direction = Direction(from: string.first!)

			let distanceString = string.dropFirst()
			guard let distance = Int(distanceString) else {
				fatalError("Invalid distance: \(distanceString)")
			}
			self.distance = distance
		}

		func apply(to position: Int) -> Int {
			switch direction {
			case .left:
				position - distance
			case .right:
				position + distance
			}
		}
	}

	public func part1(input: String) async -> String {
		let lines = input.split(separator: "\n")
		let instructions = lines.map { Instruction.init(from: $0) }

		var pos = 50
		var count = 0
		for instruction in instructions {
			pos = instruction.apply(to: pos) % 100
			if pos == 0 {
				count += 1
			}
		}

		return String(count)
	}

	public func part2(input: String) async -> String {
		return ""
	}
}
