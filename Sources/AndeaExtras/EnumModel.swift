//
// Created by Daniela Postigo on 6/22/17.
//

import Foundation

public struct Enum1 {
    private let name: String
    private let cases: [String]

    public var all: String { return Enum1.allValues(self.cases, as: self.name) }
    public var definition: String { return Enum1.definition(self) }

    // MARK: Init

    public init(name: String, cases: [String]) {
        self.name = name; self.cases = cases
    }

    // MARK: Helpers


    public static func definition(_ value: Enum1) -> String {
        let string = "enum \(value.name) {\n\(CodeUtils.cases(value.cases))\n}"
        return string
    }


    public static func allValues(_ values: [String], as name: String) -> String {
        let values = values.map({ ".\($0)" }).joined(separator: ", ")
        return "var all: [\(name)] = [\(values)]"
    }


    public static func rawStringValues(_ values: [String]) -> String {
        let cases = values.map({ "case .\($0): return \"" + $0 + "\"" }).joined(separator: "\n")
        let string = "switch self {\n\(cases.indented)\n}"
        let wrapped = "var rawValue: String {\n\(string.indented)\n}"
        return wrapped
    }

}

struct EnumModel {
    private let name: String
    private let type: EnumType
    private let cases: [String]



    var nameDeclaration: String {
        let c = [self.name] + (self.type == .none ? [] : [":", self.type.stringValue])
        return c.joined(separator: " ")
    }

}



enum EnumType: String {
    case none, string, int


    var stringValue: String {
        return self.rawValue.capitalized
    }

//    public init?(rawValue: String) {
//        self = rawValue.isEmpty ? .none : .init(rawValue: rawValue)
//    }

}


