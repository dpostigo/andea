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


extension Array where Element : Equatable {
    public mutating func remove(_ element: Iterator.Element) -> Element {
        let index = self.index(of: element)
        return self.remove(at: index!)
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

    public var arrayRepresentation: NSArray {
        return NSArray(array: Array(self))
    }


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

