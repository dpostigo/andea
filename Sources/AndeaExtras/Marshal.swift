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
    public func double(for key: KeyType) throws -> Double {
        let value = try self.any(for: key)
        guard let string = value as? String else { throw MarshalError.typeMismatch(expected: String.self, actual: type(of: value)) }
        guard let double = Double(string) else { throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: string)) }
        return double
    }
}

extension ValueType {
    public static func any(double object: Any) -> Double {
        guard let value = object as? String else { return 0 }
        guard let double = Double(value) else { return 0 }
        return double
    }

    public static func double(from object: Any) throws -> Double {
        guard let value = object as? String else { throw MarshalError.typeMismatch(expected: String.self, actual: type(of: object)) }
        guard let double = Double(value) else { throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: object)) }
        return double
    }
}


extension Date : ValueType {
    public static func value(from object: Any) throws -> Date {
        guard let double = object as? Double else {
            throw MarshalError.typeMismatch(expected: Double.self, actual: type(of: object))
        }
        return Date(timeIntervalSince1970: double)
        // assuming you have a Date.fromISO8601String implemented...
//        guard let date = Date(timeIntervalSince1970: double) else {
//            throw MarshalError.typeMismatch(expected: "ISO8601 date string", actual: double)
//        }
        // return date
    }
}
