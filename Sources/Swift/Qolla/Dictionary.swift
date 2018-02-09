//
// Created by Daniela Postigo on 1/28/18.
//

import Foundation

extension Dictionary {
	public init(pairs: [Element]) {
		self.init()
		pairs.forEach { self[$0.key] = $0.value }
	}

	public func mapKeys<K>(_ transform: (Element) throws -> K) rethrows -> [K: Value] {
		let pairs = try self.map { try (key: transform($0), value: $0.value) }
		return Dictionary<K, Value>(pairs: pairs)
	}

	public func mapPairs<K, V>(_ transform: (Element) throws -> (key: K, value: V)) rethrows -> [K: V] {
		return try Dictionary<K, V>(pairs: self.map(transform))
	}

}

prefix operator *
extension Dictionary where Key: CodingKey {
	public static prefix func *(lhs: [Key: Value]) -> [String: Value] {
		return lhs * \Key.stringValue
	}
}
extension Dictionary {

	public static func *<K>(lhs: [Key: Value], rhs: KeyPath<Key, K>) -> [K: Value] {
		return lhs.mapKeys { $0.key[keyPath: rhs] }
	}

	public static func *<K, V>(lhs: [Key: Value], rhs: (KeyPath<Key, K>, KeyPath<Value, V>)) -> [K: V] {
		let pairs = lhs.map { ($0.key[keyPath: rhs.0], $0.value[keyPath: rhs.1]) }
		return Dictionary<K, V>(pairs: pairs)
	}
}
