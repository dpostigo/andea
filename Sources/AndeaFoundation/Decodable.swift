//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation

extension Decodable {
	public static func rootObject(_ data: Data) throws -> Any {
		return try JSONDecoder.decode(data) as Self
	}

	public static func decode(_ data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(DateFormatter.iso8601Full)) throws -> Self {
		return try JSONDecoder.decode(data, dateDecodingStrategy: dateDecodingStrategy)
	}
}


extension Sequence where Element: Decodable {
	static func decode(_ data: Data) throws -> [Element] {
		return try JSONDecoder.decode(data)
	}
}

