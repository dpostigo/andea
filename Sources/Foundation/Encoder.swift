//
// Created by Daniela Postigo on 7/28/17.
//

import Foundation

extension Encodable {
	public func encodedData() throws -> Data { return try JSONEncoder.encode(self) }
}

extension Decodable {
	public static func rootObject(_ data: Data) throws -> Any { return try JSONDecoder.decode(data) as Self }
}

extension JSONEncoder {
    open class func encode<T>(_ value: T) throws -> Data where T : Encodable { return try JSONEncoder().encode(value)}
}

extension JSONDecoder {
    open class func decode<T: Decodable>(_ data: Data, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        return try decoder.decode(T.self, from: data)
    }

    open class func decode<T: Decodable>(_ data: Data, forType: T.Type) throws -> Any {
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





open class DecodableTransformer<T: Decodable>: ValueTransformer {
    open let decodableType: T.Type

    public init(forClass decodableType: T.Type) {
        self.decodableType = decodableType
        super.init()
    }

    override open class func transformedValueClass() -> Swift.AnyClass {
        return NSData.self
    }

    override open func transformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }

        do {
            return try JSONDecoder.decode(data, forType: self.decodableType)
        } catch {
            Swift.print("error = \(String(describing: error))")
        }

        return super.transformedValue(value)
    }


}
