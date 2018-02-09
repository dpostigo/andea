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
}

