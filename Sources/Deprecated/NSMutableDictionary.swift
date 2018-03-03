//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation

extension NSMutableDictionary {
	open func autocreate(keyPath: String) {
		var index: Int = 1
		var components = keyPath.components(separatedBy: ".")

		while index < components.count {
			let component = components[0 ..< index].joined(separator: ".")
			if self.value(forKeyPath: component) == nil { self.setValue(NSMutableDictionary(), forKeyPath: component)  }
			index += 1
		}
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


class Box<A> {
	var value: A
	init(_ val: A) {
		self.value = val
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

