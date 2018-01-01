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

extension Array where Element : Equatable {
	public mutating func remove(_ element: Iterator.Element) -> Element {
		let index = self.index(of: element)
		return self.remove(at: index!)
	}
}