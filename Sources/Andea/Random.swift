//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation

extension Array {
	public var random: Iterator.Element {
		return self[Int.random(0, self.count - 1)]
	}
}

extension Bool {
	public static var random: Bool { return Int.random(0, 1) == 0 ? false : true }
}


extension Int {
	public static func random(range: Int) -> CountableRange<Int> {
		return (0 ..< Int.random(0, range))
	}
	public static func randoms(_ count: Int, max: Int) -> [Int] {
		assert(count <= max, "count = \(count), max = \(max)")
		var ret: Set<Int> = Set()
		while ret.count < count {
			ret.insert(Int.random(0, max))
		}
		return Array(ret)
	}

	public static func range(_ start: Int = 0, _ end: Int) -> CountableRange<Int> {
		return (start ..< Int.random(start, end))
	}
}
