//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation

extension Array {
	public mutating func removingLast() -> Array {
		self.removeLast()
		return self
	}
}

extension Array where Element: Equatable {
	
	public mutating func insert(_ element: Element, after: Element) {
		if let index = self.index(of: after) {
			self.insert(element, at: self.index(after: index))
		}
	}
	
	public func next(after element: Element) -> Element? {
		guard let index = self.index(of: element) else { return nil }
		guard let next = self.index(index, offsetBy: 1, limitedBy: self.count - 1) else { return nil }
		return self[next]
	}
}
extension Sequence where Element: Hashable {
	public var unique: [Element] {
		return Set<Element>(self).array
	}
}


extension Sequence {
	public var array: [Element] {
		return Array(self)
	}
	public func all(_ body: (Self.Element) throws -> Bool) rethrows -> Bool {
		return try self.filter { try body($0) == false }.count > 0
	}
}


