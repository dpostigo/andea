//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation

public enum CustomLog {
    public static func customLog(name: String, value: Any, file: StaticString? = #file, line: UInt? = #line) {
        let string = self.string(name, value, file: file, line: line)
        NSLog(string)
        Swift.print(string)
    }
    
    public static func print(name: String, value: Any, file: StaticString = #file, line: UInt? = #line) {
        Swift.print(self.string(name, value, file: file, line: line))
    }
    
    private static func string(_ name: String, _ value: Any, file: StaticString?, line: UInt?) -> String {
        var components = ["[\(name)]"]
        
        switch (file?.base, line) {
            case (.none, .none): break
            case (.some(let file), .none):
                components += [file]
            case (.none, .some(let line)):
                components += ["\(line)"]
            case (.some(let file), .some(let line)):
                components += ["\(file):\(line)"]
            
        }
        components += [String(describing: value)]
        return components.joined(separator: " ") as String
    }
    
    public static func printFunction(name: String, value: Any, caller: Any, function: StaticString = #function) {
        let string = "[\(name)] \(type(of: caller)).\(function), \(value)"
        Swift.print(string)
    }
    
    public static func divider(name: String, count: Int)  {
        let divider = Array.init(repeating: "=", count: count).joined() as String
        Swift.print("[\(name)] \(divider)")
    }
    
}


extension StaticString {
    
    fileprivate var base: String? {
        guard let split = self.description.split(separator: "/").last else { return nil }
        return String(split)
    }
}

enum Log {
    static func print(_ value: Any, _ file: StaticString = #file, _ line: UInt = #line) {
        CustomLog.print(name: "Andea", value: value, file: file, line: line)
    }
    
    static func printFunction(_ value: Any, _ caller: Any, _ function: StaticString = #function) {
        CustomLog.printFunction(name: "Andea", value: value, caller: caller, function: function)
    }
    
    
    static func divider() {
        CustomLog.divider(name: "Andea", count: 100)
    }
}
