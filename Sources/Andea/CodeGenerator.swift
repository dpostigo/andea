//
// Created by Daniela Postigo on 6/22/17.
//

import Foundation

public enum CodeGenerator {

    public struct Enum {
        private let name: String
        private let cases: [String]

        public var all: String { return Enum.allValues(self.cases, as: self.name) }
        public var definition: String { return Enum.definition(self) }

        // MARK: Init

        public init(name: String, cases: [String]) {
            self.name = name; self.cases = cases
        }

        // MARK: Helpers


        public static func definition(_ value: Enum) -> String {
            let string = "enum \(value.name) {\n\(self.cases(value.cases))\n}"
            return string
        }

        public static func cases(_ values: [String]) -> String {
            return values.map({ "case \($0)" }).joined(separator: "\n").indented
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

}

extension String {
    public var indented: String { return self.indent() }
    public func indent(_ amount: Int = 1) -> String {
        let indent = (0 ..< amount).map({ _ in "\t" }).joined()
        let indented = self.components(separatedBy: "\n").map({ indent + $0 })
        return indented.joined(separator: "\n")
    }
}


