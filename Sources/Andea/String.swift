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
}

extension NSObject {

    public func toggle(forKeyPath path: String) {
//        guard let value = self.value(forKeyPath: path) else { return }
        guard let value = self.value(forKeyPath: path) as? Bool else {
            Swift.print("didn't find")
            return }

        Swift.print("\(path) = \(self.value(forKeyPath: path))")
        self.setValue(!value, forKeyPath: path)
        Swift.print("\(path) changed = \(self.value(forKeyPath: path))")
    }

    public func printValues(forKeyPaths paths: [String]) -> String {
        return self.debugValues(forKeyPaths: paths).indented
//        Swift.print("\(self.debugValues(forKeyPaths: keyPaths).indented)")

        //        var string = self.debugValues(forKeyPaths: keyPaths)
//        string = "DEFAULTS:\n\(string.indented)"
//        Swift.print(string)
    }
    public func debugValues(forKeyPaths paths: [String]) -> String {
        return paths.map({ path in

            let value = self.value(forKeyPath: path) ?? "nil"
            if let boolean = value as? Bool {

                return "\(path) = \(boolean)"
            }
            return "\(path) = \(value)"
            
            
        }).joined(separator: "\n")
    }
}
