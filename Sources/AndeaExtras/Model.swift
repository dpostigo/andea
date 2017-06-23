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
        let props = self.properties.map({ $0.stringValue }).joined(separator: "\n")

        var string = self.modifier + "struct \(self.name): Unmarshaling {\n"
        string += "\(props.indented)\n\n"
        string += "\(self.initializer.indented)\n"
        string += "}"
        return string
    }

    public var initializer: String {
        let props = self.properties.map({ $0.initializer }).joined(separator: "\n")
        let string = self.modifier + "init(object: MarshaledObject) throws {\n\(props.indented)\n}"
        return string
    }

    // MARK: Init

    public init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.properties = try object.value(for: "properties")
        self.isPublic = object.optionalAny(for: "public") as? Bool ?? true
    }

    public static func from(json: JSON) throws -> [Model] {
        return try json.value(for: "models")
    }


    private var modifier: String {
        return self.isPublic ? "public " : ""
    }

    struct Property: Unmarshaling {
        let name: String
        let type: String
        let optional: Bool

        init(object: MarshaledObject) throws {
            self.name = try object.value(for: "name")
            self.type = try object.value(for: "type")
            // self.optional = object.optionalAny(for: "optional") as? Bool ?? false

            guard let last = self.type.characters.last else {
                self.optional = false
                return
            }

            self.optional = String(last) == "?"
        }


        var initializer: String {
            return "self.\(self.name) = try object.value(for: \"\(self.name)\")"
        }

        var stringValue: String {
            return (self.optional ? "var" : "let") + " \(name): \(type)"
        }
    }


    //
    //"properties": [
    //{"name": "id", "type": "String"},
    //{"name": "name", "type": "String"},
    //{"name": "delisted", "type": "Bool"},
    //{"name": "disabled", "type": "Bool"},
    //{"name": "depositAddress", "type": "String?"}
    //]
}
