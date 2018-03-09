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
}
