//
// Created by Dani Postigo on 11/18/16.
//

import Foundation

extension Sequence {
    public func take(_ find: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
        var generator = self.makeIterator()
        while let elem = generator.next() {
            if (find(elem)) {
                return elem
            }
        }
        return nil
    }
}
