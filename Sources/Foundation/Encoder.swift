//
// Created by Daniela Postigo on 7/28/17.
//

import Foundation

extension JSONDecoder {
    open class func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
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
