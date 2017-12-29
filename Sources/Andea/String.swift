//
// Created by Daniela Postigo on 7/1/17.
//

import Foundation

extension String {
    public var indented: String { return self.indent() }
    public var whitespaced: String { return self.whitespace() }


    public func whitespace(_ amount: Int = 2) -> String {
        return self.prepend(repeating: " ", count: amount)
    }

    public func indent(_ amount: Int = 1) -> String {
        let indent = (0 ..< amount).map({ _ in "\t" }).joined()
        let indented = self.components(separatedBy: "\n").map({ indent + $0 })
        return indented.joined(separator: "\n")
    }


    public func prepend(repeating: String, count: Int) -> String{
        let repeatedValue = Array(repeating: repeating, count: count).joined()
        return self.prepend(repeatedValue)
    }

    public func prepend(_ value: String) -> String {
        let prepended = self.components(separatedBy: "\n").map({ value + $0 })
        return prepended.joined(separator: "\n")
    }

    public var capitalizedFirst: String {
        let characters = Array(self).enumerated().map({ $0.offset == 0 ? String($0.element).capitalized : String($0.element) })
        return characters.joined()
    }

    public var lowercasedFirst: String {
        let characters = Array(self).enumerated().map({ $0.offset == 0 ? String($0.element).lowercased() : String($0.element) })
        return characters.joined()
    }

    public var kebabName: String {
        return self.replacingOccurrences(of: "_", with: "-")
    }
}


extension Sequence where Self.Iterator.Element == String {
    public var indented: String { return self.indent() }
    public var whitespaced: String { return self.whitespace() }

    public func whitespace(_ amount: Int = 2) -> String {
        return self.map({ $0.whitespace(amount) }).newLines
    }

    public func indent(_ amount: Int = 1) -> String {
        return self.map({ $0.indent(amount) }).newLines
    }

    public var newLines: String {
        return self.joined(separator: "\n")
    }

//    public func newLines(_ transform: (Iterator.Element) -> String) -> String {
//        return self.map(transform).joined(separator: "\n")
//    }

}

