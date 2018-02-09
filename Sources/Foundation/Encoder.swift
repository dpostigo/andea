//
// Created by Daniela Postigo on 7/28/17.
//

import Foundation

extension Encodable {
	public func encodedData() throws -> Data { return try JSONEncoder.encode(self) }

    public func json() throws -> [String: Any] {
        return try JSONSerialization.json(with: self.encodedData())
    }

    public func json() throws -> [JSON] {
        return try JSONSerialization.json(with: self.encodedData())
    }

}

extension JSONEncoder {
    public class func encode<T: Encodable>(_ value: T) throws -> Data {
        return try JSONEncoder().encode(value)
    }
}

extension JSONDecoder {
    public class func decode<T: Decodable>(_ data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return try decoder.decode(T.self, from: data)
    }

    public class func decode<T: Decodable>(_ data: Data, forType: T.Type) throws -> Any {
        do {
            return try self.decode(data) as [T]
        } catch {
            switch error {
                case DecodingError.typeMismatch(let type, _) :
                    guard type is [Any].Type else { throw error }
                    return try self.decode(data) as T

                default : throw error
            }
        }
    }
    
}

extension JSONDecoder {
    
    public class func decode<T: Decodable>(_ type: T.Type, from data: Data,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .formatted(DateFormatter.iso8601Full)
    ) throws -> T {
        let decoder = JSONDecoder.init()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return try decoder.decode(type, from: data)
    }
}
