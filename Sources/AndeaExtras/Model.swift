//
// Created by Daniela Postigo on 6/22/17.
//

import Foundation
import Marshal

public struct Model: Unmarshaling {
    private let name: String
    private let properties: [Property]
    private let isPublic: Bool

    public var definition: String {
        var string = self.modifier + "struct \(self.name): Unmarshaling {\n"
        string += "\(self.properties.declarations.indented)\n\n"
        string += "\(self.initializer.indented)\n"
        string += "}"
        return string
    }

    public var initializer: String {
        var string = self.modifier + "init(object: MarshaledObject) throws {\n"
        string += "\(self.properties.initializers.indented)\n}"
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


fileprivate struct Property: Unmarshaling {
    private let name: String
    private let type: String
    private let optional: Bool
    private let modifier: String

    // MARK: Public

    var initializer: String { return "self.\(self.name) = try object.value(for: \"\(self.name)\")" }
    var declaration: String { return (self.optional ? "var" : "let") + " \(name): \(type)" }

    init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.type = try object.value(for: "type")
        self.modifier = object.optionalAny(for: "modifier") as? String ?? "private"
        // self.optional = object.optionalAny(for: "optional") as? Bool ?? false

        guard let last = self.type.characters.last else { self.optional = false; return }
        self.optional = String(last) == "?"
    }
}


protocol Definition {
    var isPublic: Bool { get }
}

extension Definition {


}

enum Modifier {
    case isPublic
    case isPrivate
    case isFileprivate
}

fileprivate extension Collection where Self.Iterator.Element == Property {

    var initializers: String {
        return self.map({ $0.initializer }).joined(separator: "\n")
    }

    var declarations: String {
        return self.map({ $0.declaration }).joined(separator: "\n")
    }

}

extension Unmarshaling {
    public static func from(_ array: Any) throws -> [Self] {
        return try Array.value(from: array)
//        return try ["value": array].value(for: "value")
    }
}
