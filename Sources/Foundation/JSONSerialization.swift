//
//  JSONSerialization.swift
//  Pods
//
//  Created by Daniela Postigo on 8/26/17.
//

import Foundation

extension JSONSerialization {
    public enum SerializationError: Error {
        case typeMismatch(expected: Any, actual: Any)
    }
    
    public class func json<T>(data: Data, _ jsonType: T.Type = T.self, options: JSONSerialization.ReadingOptions = []) throws -> T {
        let value = try self.jsonObject(with: data, options: options)
        let converted = value as? T
        switch converted {
            case .none: throw SerializationError.typeMismatch(expected: jsonType.self, actual: type(of: value))
            case .some(let json): return json
        }
    }
    public class func json(_ data: Data, options: JSONSerialization.ReadingOptions = []) throws -> Any {
        return try JSONSerialization.jsonObject(with: data, options: options)
    }
}

