//
// Created by Daniela Postigo on 6/22/17.
//

import Foundation
import Marshal

public struct Model: Unmarshaling {
    private let name: String
    private let properties: [Property2]
    private let isPublic: Bool

    public var marshals: Bool = false

    public var definition: String {
        var string = self.modifier + "struct \(self.name): \(self.inheritance) {\n"
        string += "\(self.properties.declarations.indented)\n\n"
        string += "\(self.initializer.indented)\n"
        string += self.marshals ? "\(self.serializer.indented)\n" : ""
        string += "}"
        return string

    }

    private var inheritance: String {
        return self.marshals ? "Unmarshaling, Marshaling" : "Unmarshaling"
    }

    public var initializer: String {
        var string = self.modifier + "init(object: MarshaledObject) throws {\n"
        string += "\(self.properties.initializers.indented)\n}"
        return string
    }

    public var serializer: String {
        var string = "public func marshaled() -> [String: Any] {\n"
        string += "\(self.properties.serializer.indented)\n}"
        return string
    }

    // MARK: Init

    public init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.properties = try object.value(for: "properties")
        self.isPublic = object.optionalAny(for: "public") as? Bool ?? true
    }

    // MARK: Helpers

    private var modifier: String { return self.isPublic ? "public " : "" }


}


fileprivate struct Property2: Unmarshaling {
    private let name: String
    private let type: String
    private let optional: Bool
//    private let modifier: String

    // MARK: Public

    init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.type = try object.value(for: "type")
         self.optional = object.optionalAny(for: "optional") as? Bool ?? false
    }

    var declaration: String {
        return (self.optional ? "var" : "let") + " \(name): \(type)"
    }

    var initializer: String {
        return "self.\(self.name) = try object.\(self.deserializer)"
    }

    var serialized: String {
        return "\"\(self.name)\" : self.\(self.name)"
    }

    var deserializer: String {
        switch self.type.marshalType {
            case .any : return "any(for: \"\(self.name)\")"
            case .optional : return "optionalAny(for: \"\(self.name)\")"
            case .value : return "value(for: \"\(self.name)\")"
        }
    }

}

fileprivate enum MarshalValueType {
    case any, optional, value
}

extension String {

    fileprivate var marshalType: MarshalValueType {
        guard !self.isOptional else { return .optional }
        return self == "Any" ? .any : .value
    }

    fileprivate var isOptional: Bool {
        guard let last = self.last else { return false }
        return last == "?"
    }

    fileprivate var last: String? {
        guard let last = self.characters.last else { return nil }
        return String(last)
    }
}



fileprivate extension Collection where Self.Iterator.Element == Property2 {

    var initializers: String {
        return self.map({ $0.initializer }).joined(separator: "\n")
    }

    var declarations: String {
        return self.map({ $0.declaration }).joined(separator: "\n")
    }

    var serializer: String {
        return "return [\n\(self.serializers.indented)\n]"
    }

    var serializers: String {
        return self.map({ $0.serialized }).joined(separator: ",\n")
    }

}

