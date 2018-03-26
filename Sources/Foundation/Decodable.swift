//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation

extension Sequence where Element: Decodable {
	static func decode(_ data: Data) throws -> [Element] {
		return try JSONDecoder.decode(data)
	}
}

extension Decodable {
	public static func decode(
		_ data: Data,
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
		dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
		nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy = .throw,
		userInfo: [CodingUserInfoKey: Any]? = nil
	) throws -> Self {
		return try JSONDecoder.decode(
			data,
			dateDecodingStrategy: dateDecodingStrategy,
			dataDecodingStrategy: dataDecodingStrategy,
			nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy,
			userInfo: userInfo
		)
	}
}

extension JSONDecoder {
	class func decode<T: Decodable>(
		_ data: Data,
		decodableType: T.Type = T.self,
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
		dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
		nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy = .throw,
		userInfo: [CodingUserInfoKey: Any]? = nil
	) throws -> T {
		let decoder = JSONDecoder(
			dateDecodingStrategy: dateDecodingStrategy,
			dataDecodingStrategy: dataDecodingStrategy,
			nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy,
			userInfo: userInfo
		)
		return try decoder.decode(decodableType, from: data)
	}
	
	convenience init(
		dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
		dataDecodingStrategy: JSONDecoder.DataDecodingStrategy = .base64,
		nonConformingFloatDecodingStrategy: JSONDecoder.NonConformingFloatDecodingStrategy = .throw,
		userInfo: [CodingUserInfoKey: Any]? = nil
	
	) {
		self.init()
		self.dateDecodingStrategy = dateDecodingStrategy
		self.dataDecodingStrategy = dataDecodingStrategy
		self.nonConformingFloatDecodingStrategy = nonConformingFloatDecodingStrategy
		userInfo.some { self.userInfo = $0 }
	}
}
