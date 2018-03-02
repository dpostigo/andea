//
// Created by Daniela Postigo on 1/24/18.
//

import Foundation

typealias RawRepresentableCodingKey = RawRepresentable & CodingKey & Hashable

extension CodingKey where Self: RawRepresentable, Self.RawValue == Int {
	public static var all: [Self] {
		var ret: [Self] = []
		var index: Int = 0
		while let value = Self.init(rawValue: index) {
			index += 1; ret.append(value)
		}
		return ret
	}
	
	public static func map<T>(_ transform: (Self) throws -> T) rethrows -> [T] {
		return try self.all.map(transform)
	}
}

extension Sequence where Element: CodingKey {
	public var stringValues: [String] {
		return self.map { $0.stringValue }
	}
}