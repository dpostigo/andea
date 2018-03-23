//
// Created by Daniela Postigo on 3/9/18.
//

import Foundation

extension Autorepresentable where Self: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self = try container.decode()
    }
}

fileprivate enum ValueType {
    case int(Int)
    case string(String)
    
    init(container: SingleValueDecodingContainer) throws {
        let values = try ValueType.valueTypes(from: container)
        switch values.first {
            case .none: throw DecodingError.dataCorruptedError(
                in: container,
                debugDescription: "Andea.Autorepresentable decoding failed. Implement a custom init(from:)"
            )
            case .some(let first): self = first
        }
    }
    
    init(rawValueType: RawValueType, container: SingleValueDecodingContainer) throws {
        switch rawValueType {
            case .int: self = try .int(container.decode(Int.self))
            case .string: self = try .string(container.decode(String.self))
        }
    }
    
    static func valueTypes(from: SingleValueDecodingContainer) throws -> [ValueType] {
        return RawValueType.all.flatMap { try? ValueType(rawValueType: $0, container: from) }
    }
}

extension Autorepresentable {
    fileprivate init?(rawValueType: ValueType) {
        switch rawValueType {
            case .int(let intValue): self.init(rawValue: intValue)
            case .string(let stringValue): self.init(stringValue: stringValue)
        }
    }
}

enum RawValueType: Int, Autorepresentable {
    case int
    case string
}


extension SingleValueDecodingContainer {
    
    fileprivate func decode<T: Autorepresentable>(_ type: T.Type = T.self) throws -> T {
        let rawValueType = try ValueType(container: self)
        let value = T.init(rawValueType: rawValueType)
        switch value {
            case .none: throw DecodingError.dataCorruptedError(in: self, debugDescription: "")
            case .some(let value): return value
        }
    }
}

