//
// Created by Daniela Postigo on 8/3/17.
//

import Foundation


public protocol Autorepresentable: RawRepresentable {
	associatedtype RawValue = Int
}

extension Autorepresentable where Self.RawValue == Int {

	typealias RawValue = Int
	public var integerRepresentation: Int { return self.rawValue }

	// String representation

	public init?(string: String) {
		guard let value = Self.autorepresentation(from: string) else { return nil }
		self = value
	}

	public static func autorepresentation(from string: String) -> Self? {
		guard let index = self.stringRepresentations.index(of: string) else { return nil }
		return Self(rawValue: index)
	}
}

extension Autorepresentable {
	public static var representations: [Self] {
		return (0 ... self.autoterminatingRepresentation.rawValue).flatMap({ return Self(rawValue: $0) })
	}

	private static var autoterminatingRepresentation: Self {
		var ret = Self(rawValue: 0)!
		while let value = Self(rawValue: ret.rawValue + 1) {
			ret = value
		}
		return ret
	}
}

extension Autorepresentable {
	public static var integerRepresentations: [Int] {
		return self.representations.map({ $0.integerRepresentation })
	}

	public static var stringRepresentations: [String] {
		return self.representations.map({ $0.stringRepresentation })
	}
}



extension Autorepresentable {
	static var integerRepresentations1: [Int] { return self.representations(forType: Int.self) }
	static var stringRepresentations1: [String] { return self.representations(forType: String.self) }

	private static func representations<T: Any>(forType representationType: T.Type) -> [T] {
	return self.representations.flatMap({ $0.representation(forType: representationType) })
}

private func representation<T: Any>(forType representationType: T.Type) -> T? {
	switch representationType {
		case is Int.Type : return self.integerRepresentation as? T
		case is String.Type: return self.stringRepresentation as? T
		default: return nil
	}
}
}