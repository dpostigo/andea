//
// Created by Dani Postigo on 4/8/17.
//

import Foundation

extension RangeReplaceableCollection {
    func appending(_ item: Self.Iterator.Element) -> Self {
        var ret = Array(self) as! Self
        ret.append(item)
        return ret
    }
}

extension Sequence {
    public func select(_ find: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
        var generator = self.makeIterator()
        while let elem = generator.next() {
            if(find(elem)) {
                return elem
            }
        }
        return nil
    }
}
