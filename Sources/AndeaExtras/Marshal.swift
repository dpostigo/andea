//
// Created by Daniela Postigo on 6/26/17.
//

import Foundation
import Marshal

extension Unmarshaling {
    public static func from(_ array: Any) throws -> [Self] {
        return try Array.value(from: array)
    }
}

extension KeyType where Self: RawRepresentable, Self.RawValue == Int {
    public var stringValue: String { return String(describing: self) }
}

extension KeyType where Self: RawRepresentable, Self.RawValue == String {
    public var stringValue: String { return self.rawValue }
}


extension Unmarshaling {
    public static func resultArray(_ json: Any, completion: (([Self]) -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        do {
            let items: [Self] = try Self.from(json)
            completion?(items)
        } catch {
            failure?(error)
        }
    }
}


extension MarshaledObject {
    public func optionalDouble(for key: KeyType) -> Double? {
        return (try? self.double(for: key)) ?? nil
    }

    public func double<A: ValueType>(for key: KeyType) throws -> A {
        let any = try self.any(for: key)
        do {
            guard let result = try A.double(from: any) as? A else {
                throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: A.self, actual: type(of: any))
            }
            return result
        }
        catch let MarshalError.typeMismatch(expected: expected, actual: actual) {
            throw MarshalError.typeMismatchWithKey(key: key.stringValue, expected: expected, actual: actual)
        }
    }


    public func unixDate(for key: KeyType) throws -> Date {
        let value = try self.any(for: key)
        do {
            return try Date.unixDate(from: value)
        } catch  {

            if let error = error as? MarshalError {
                switch error {
                    case let .typeMismatch(expected, actual):
                        throw MarshalError.typeMismatchWithKey(key: key, expected: expected, actual: actual)
                    default: throw error
                }
            } else {
                throw error
            }
           
        }

    }

}

extension ValueType {
    public static func any(double object: Any) -> Double {
        guard let value = object as? String else { return 0 }
        guard let double = Double(value) else { return 0 }
        return double
    }

    public static func double(from object: Any) throws -> Double {
        if let value = object as? NSNumber {
            return value.doubleValue
        } else {
            guard let value = object as? String else { throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object)) }
            guard let double = Double(value) else { throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: object)) }
            return double
        }
    }
}


extension Date : ValueType {

    static let unixFormatter = DateFormatter(dateFormat: "yyyy-MM-dd HH:mm:ss")

    public var unixString: String {
        return Date.unixFormatter.string(from: self)
    }

    public static func unixDate(from object: Any) throws -> Date {
        guard let string = object as? String else {
            throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object)) }
        guard let date = Date.unixFormatter.date(from: string) else { throw MarshalError.typeMismatch(expected: "UNIX date string", actual: string) }
        return date
    }

    public static func value(from object: Any) throws -> Date {
        guard let double = object as? Double else {
            throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: object))
        }
        return Date(timeIntervalSince1970: double)
    }
}
