//
// Created by Daniela Postigo on 12/6/17.
//

import Foundation

public protocol AutoDecodable { }
extension Int: AutoDecodable { }
extension String: AutoDecodable { }

public enum AutoDecodableType: String {
	case id
	case title
	case description
	fileprivate func key<T: CodingKey>() -> T { return T(stringValue: self.rawValue)! }
}

extension KeyedDecodingContainer {

	public func decode<T: AutoDecodable>(_ decodableType: AutoDecodableType) throws -> T {
		switch decodableType {
			case .id: return try self.decode(Int.self, forKey: decodableType.key()) as! T
            case .title: return try self.decode(String.self, forKey:  decodableType.key()) as! T
            case .description: return try self.decode(String.self, forKey:  decodableType.key()) as! T
		}
	}

	func decode<T: AutoDecodable>(_ type: T.Type = T.self, forKey key: Key) throws -> T {
		return try self.decode(type, forKey: key)
	}
}
