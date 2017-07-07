//
// Created by Daniela Postigo on 7/1/17.
//

import Foundation

extension String {
    public var indented: String { return self.indent() }
    public func indent(_ amount: Int = 1) -> String {
        let indent = (0 ..< amount).map({ _ in "\t" }).joined()
        let indented = self.components(separatedBy: "\n").map({ indent + $0 })
        return indented.joined(separator: "\n")
    }

    public var capitalizedFirst: String {
        let characters = self.characters.enumerated().map({ $0.offset == 0 ? String($0.element).capitalized : String($0.element) })
        return characters.joined()
    }

    public var lowercasedFirst: String {
        let characters = self.characters.enumerated().map({ $0.offset == 0 ? String($0.element).lowercased() : String($0.element) })
        return characters.joined()
    }
}

extension NSObject {

}
