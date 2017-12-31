//
//  JSONSerialization.swift
//  Pods
//
//  Created by Daniela Postigo on 8/26/17.
//

import Foundation

extension JSONSerialization {

    open class func string(_ obj: Any, options opt: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: obj, options: opt)
            return String(data: data, encoding: .utf8)!
        }
        catch { return String(describing: error) }
    }


    open class func jsonObject<T: Encodable>(with value: T) throws -> Any {
        let data = try JSONEncoder.encode(value)
        return try self.jsonObject(with: data)
    }
}


extension Dictionary where Key == String {

    public var prettyPrinted: String {
        return JSONSerialization.string(self)
    }

}

extension JSONSerialization {
    public enum JSONError: Error {
        case typeMismatch(expected: Any, actual: Any)
    }

    public class func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any] {
        do {
            let value = try JSONSerialization.jsonObject(with: data, options: opt)
            guard let json = value as? JSON else { throw JSONError.typeMismatch(expected: JSON.self, actual: type(of: value)) }
            return json
        } catch { throw error }
    }

    public class func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [JSON] {
        do {
            let value = try JSONSerialization.jsonObject(with: data, options: opt)
            guard let json = value as? [JSON] else { throw JSONError.typeMismatch(expected: [JSON].self, actual: type(of: value)) }
            return json
        } catch { throw error }
    }
}

