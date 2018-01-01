//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation

extension Sequence {
	public func select(_ find: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
		var generator = self.makeIterator()
		while let elem = generator.next() {
			if (find(elem)) { return elem }
		}
		return nil
	}
}

extension RangeReplaceableCollection  {
	public func appending(_ item: Self.Iterator.Element) -> Self {
		return self.appending([item])
	}

	public func appending(_ item: [Self.Iterator.Element]) -> Self {
		var ret = Array(self) as! Self
		ret.append(contentsOf: ret)
		return ret
	}
}

