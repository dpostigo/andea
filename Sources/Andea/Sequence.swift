//
// Created by Dani Postigo on 11/18/16.
//

import Foundation

class Box<A> {
    var value: A
    init(_ val: A) {
        self.value = val
    }
}

extension Dictionary {
    @discardableResult public func appending(_ value: Value?, forKey key: Key) -> Dictionary<Key, Value> {
        var ret = self
        ret.append(value, forKey: key)
        return ret
    }

    @discardableResult public mutating func append(_ value: Value?, forKey key: Key) -> Dictionary<Key, Value> {
        guard let value = value else { return self }
        self[key] = value
        return self
    }
}

extension Sequence {
    public func group<U: Hashable>(by key: (Iterator.Element) -> U) -> [U:[Iterator.Element]] {
        var categories: [U: Box<[Iterator.Element]>] = [:]
        for element in self {
            let key = key(element)
            if case nil = categories[key]?.value.append(element) {
                categories[key] = Box([element])
            }
        }
        var result: [U: [Iterator.Element]] = Dictionary(minimumCapacity: categories.count)
        for (key,val) in categories {
            result[key] = val.value
        }
        return result
    }
}

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
