//
// Created by Daniela Postigo on 1/18/18.
//

import Foundation

extension RawRepresentable {
	public var name: String { return Mirror.customReflect(self) }
}

extension RawRepresentable where Self.RawValue == Int {

	public init?(intValue: Int) {
		guard let value = Self.init(rawValue: intValue) else { return nil }
		self = value
	}

	public init?(stringValue: String) {
		guard let index = Self.all.index(where: { $0.stringValue == stringValue }) else { return nil }
		self.init(rawValue: index)
	}

	public var stringValue: String {
		return Mirror.customReflect(self)
	}

	public static var all: [Self] {
		var ret: [Self] = []
		var index: Int = 0
		while let value = Self.init(rawValue: index) {
			index += 1; ret.append(value)
		}
		return ret
	}

	public static var count: Int {
		return Self.all.count
	}
	
	public static var stringValues: [String] {
		return Self.all.stringValues
	}
}

extension Sequence where Element: RawRepresentable, Element.RawValue == Int {
	public var stringValues: [String] {
		return self.map { $0.stringValue }
	}
}

extension RawRepresentable where Self: Equatable {

	public static func -(lhs: [Self], rhs: Self) -> [Self] {
		return lhs - [rhs]
	}
}


