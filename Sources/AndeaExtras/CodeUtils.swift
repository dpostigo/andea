//
// Created by Daniela Postigo on 6/23/17.
//

import Foundation

extension String {
    public var indented: String { return self.indent() }
    public func indent(_ amount: Int = 1) -> String {
        let indent = (0 ..< amount).map({ _ in "\t" }).joined()
        let indented = self.components(separatedBy: "\n").map({ indent + $0 })
        return indented.joined(separator: "\n")
    }
}

enum Generative {
    case `enum`
    case model
}

public enum CodeUtils {
    public static func cases(_ values: [String]) -> String {
        return values.map({ "case \($0)" }).joined(separator: "\n").indented
    }



//    public static func `enum`(_ value: Enum) -> String {
//        let string = "enum \(value.name) {\n\(CodeUtils.cases(value.cases))\n}"
//        return string
//    }

}