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
