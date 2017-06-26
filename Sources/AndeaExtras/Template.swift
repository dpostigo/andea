//
// Created by Daniela Postigo on 6/26/17.
//

import Foundation

enum Initializer {
    case ivar

    var template: String {
        switch self {
            case .ivar: return
        }
    }

}


public protocol Definable {
    var definition: String { get }
    var initializer: String { get }
}

struct Ivar: Definable {
    static let Declaration = "<#keyword#><#name#> : <#type#>"
    static let Initializer = "self.<#name#> = try object.<#function#>(for: \"<#name#>\")"

    let keyword: String?
    let name: String
    let type: String


    init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.type = try object.value(for: "type")
        self.keyword = self.type.marshalType == .optional ? "var" : keyword
    }

    init(keyword: String? = nil, name: String, type: String) {
        self.name = name
        self.type = type
        self.keyword = self.type.marshalType == .optional ? "var" : keyword
    }

    var initializer: String {
        let template = Ivar.Initializer
        template.replace(placeholderStrings: { string in
            switch string {
                case "name": return self.name
                case "function": return self.function
                default : break
            }
        })
    }

    var definition: String {
        let template = Ivar.Declaration
        template.replace(placeholderStrings: { string in
            switch string {
                case "keyword": return self.keyword ?? ""
                case "name": return self.name
                case "type": return self.type
                default : break
            }
        })
    }


    var function: String {
        switch self.type.marshalType {
            case .any : return "any"
            case .optional : return "optionalAny"
            case .value : return "value"
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


extension String {
    static let placeholderStart = "<#"
    static let placeholderEnd = "#>"

    public mutating func replace(placeholderStrings block: (String) -> String) {
        self.replace(placeholders: { string in
            let start = string.index(string.startIndex, offsetBy: 2)
            let end = string.index(string.endIndex, offsetBy: -2)
            let string2 = string.substring(with: start ..< end)
            return block(string2)
        })
    }
    public mutating func replace(placeholders block: (String) -> String) {
        while let range = self.rangeOfPlaceholder() {
            let placeholder = self.substring(with: range)
            self.replaceSubrange(range, with: block(placeholder))
        }
    }

    func rangeOfPlaceholder() -> Range<Index>? {
        guard let range1 = self.range(of: String.placeholderStart) else { return nil }
        guard let range2 = self.range(of: String.placeholderEnd) else { return nil }
        return range1.lowerBound ..< range2.upperBound
    }
}

