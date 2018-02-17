//
// Created by Daniela Postigo on 1/24/18.
//

import Foundation

extension Array where Element: Equatable {
    public mutating func remove(_ element: Element) -> Element {
        let index = self.index(of: element)
        return self.remove(at: index!)
    }
    
	public static func -(lhs: [Element], rhs: [Element]) -> [Element] {
		var lhs = lhs
		rhs.forEach { _ = lhs.remove($0) }
		return lhs
	}
}

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

