import Foundation
import Utils

public struct Day08: Day {
	public init() {}

	public func part1(input: String) async -> String {
		await part1(input: input, connectionCount: 1000)
	}

	public func part1(input: String, connectionCount: Int) async -> String {
		let boxes = JunctionBox.parseBoxes(from: input)
		let pairs = boxes.enumerated().flatMap { i, boxA in
			boxes[(i + 1)...].compactMap {
				JunctionBox.Pair(boxA: boxA, boxB: $0)
			}
		}.sorted { $0.distanceSquared < $1.distanceSquared }
		let circuits = boxes.map { $0.circuit }

		for pair in pairs[0..<connectionCount] {
			pair.boxA.circuit.connect(to: pair.boxB.circuit)
		}

		return
			circuits
			.filter { !$0.junctionBoxes.isEmpty }
			.map { $0.junctionBoxes.count }
			.sorted { $0 > $1 }
			.prefix(3)
			.product()
			.description
	}

	public func part2(input: String) async -> String {
		let boxes = JunctionBox.parseBoxes(from: input)
		let pairs = boxes.enumerated().flatMap { i, boxA in
			boxes[(i + 1)...].compactMap {
				JunctionBox.Pair(boxA: boxA, boxB: $0)
			}
		}.sorted { $0.distanceSquared < $1.distanceSquared }
		var circuits = boxes.map { $0.circuit }

		for pair in pairs {
			pair.boxA.circuit.connect(to: pair.boxB.circuit)
			circuits.removeAll { $0.junctionBoxes.isEmpty }

			if circuits.count == 1 {
				return (pair.boxA.pos.x * pair.boxB.pos.x).description
			}
		}

		fatalError("no way to close the circuits")
	}
}

struct Coord: Hashable {
	let x, y, z: Int

	init(from string: some StringProtocol) {
		let parts = string.split(separator: ",").map { Int($0)! }
		x = parts[0]
		y = parts[1]
		z = parts[2]
	}

	func distanceSquared(from other: Coord) -> Double {
		let dx = Double(x - other.x)
		let dy = Double(y - other.y)
		let dz = Double(z - other.z)
		return dx * dx + dy * dy + dz * dz
	}
}

class JunctionBox: Hashable {
	let pos: Coord
	var circuit: Circuit

	init(pos: Coord) {
		self.pos = pos
		self.circuit = Circuit()
		self.circuit.junctionBoxes.insert(self)
	}

	static func == (lhs: JunctionBox, rhs: JunctionBox) -> Bool {
		return lhs.pos == rhs.pos
	}

	func hash(into hasher: inout Hasher) {
		hasher.combine(pos)
	}

	static func parseBoxes(
		from input: some StringProtocol
	) -> [JunctionBox] {
		let lines = input.split(separator: "\n")

		var boxes = [JunctionBox]()
		for line in lines {
			let box = JunctionBox(pos: Coord(from: line))
			boxes.append(box)
		}

		return boxes
	}

	struct Pair {
		let boxA: JunctionBox
		let boxB: JunctionBox
		let distanceSquared: Double

		init?(boxA: JunctionBox, boxB: JunctionBox) {
			guard boxA !== boxB else { return nil }
			self.boxA = boxA
			self.boxB = boxB
			self.distanceSquared = boxA.pos.distanceSquared(from: boxB.pos)
		}
	}

	class Circuit {
		var junctionBoxes = Set<JunctionBox>()

		func connect(to other: Circuit) {
			guard other !== self else { return }

			junctionBoxes.formUnion(other.junctionBoxes)
			for box in junctionBoxes {
				box.circuit = self
			}
			other.junctionBoxes.removeAll()
		}
	}
}
