//
// Created by Daniela Postigo on 8/3/17.
//

import Foundation

public protocol StringRepresentable {
    var stringValue: String { get }
    var stringRepresentation: String { get }
}

public protocol IntRepresentable: RawRepresentable where RawValue == Int {
    
}

public typealias Autorepresentable = StringRepresentable & IntRepresentable

extension RawRepresentable where Self: Autorepresentable {
    
    public var stringValue: String { return String(describing: self) }
    public var stringRepresentation: String { return type(of: self).string(describing: self) }
    
    private static func string(describing value: Self) -> String {
        let string = String(describing: value)
        guard string.contains("("), let index = string.index(of: "(") else { return string }
        return String(string[..<index])
        // return string.substring(to: index)
    }
    
    public var integerRepresentation: Int {
        return self.rawValue
    }
    
    // String representation
    
    public init?(string: String) {
        guard let value = Self.autorepresentation(from: string) else { return nil }
        self = value
    }
    
    public static func autorepresentation(from string: String) -> Self? {
        guard let index = self.stringRepresentations.index(of: string) else { return nil }
        return Self(rawValue: index)
    }
    
    // MARK: Representations
    
    public static var integerRepresentations: [Int] {
        return self.representations.map({ $0.integerRepresentation })
    }
    
    public static var stringRepresentations: [String] {
        return self.representations.map({ $0.stringRepresentation })
    }
    #if os(OSX)
    public static var itemIdentifiers: [NSUserInterfaceItemIdentifier] {
        return self.stringRepresentations.map({ NSUserInterfaceItemIdentifier(rawValue: $0) })
    }
    #endif
    
    // MARK: Raw representations
    
    public static var representations: [Self] {
        return (0 ... self.autoterminatingRepresentation.rawValue).flatMap({ return Self(rawValue: $0) })
    }
    
    private static var autoterminatingRepresentation: Self {
        var ret = Self(rawValue: 0)!
        while let value = Self(rawValue: ret.rawValue + 1) {
            ret = value
        }
        return ret
    }
}


