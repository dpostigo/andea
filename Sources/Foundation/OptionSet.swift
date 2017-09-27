//
//  OptionSet.swift
//  Pods
//
//  Created by Daniela Postigo on 8/28/17.
//

import Foundation


public protocol IndexedOptionSet: OptionSet where RawValue == Int {
    static var end: Self { get }
}

extension IndexedOptionSet {
    public static var options: [Self] { return (0 ... (self.end.rawValue >> 1)).map({ return Self(rawValue: 1 << $0) }) }
    
    public func forEach(_ body: (Self) throws -> Void) rethrows {
        try Self.options.filter({ !self.isDisjoint(with: $0) }).forEach(body)
    }
}

public protocol NamedOptionSet: OptionSet, CustomDebugStringConvertible where RawValue == Int {
    associatedtype Name: Autorepresentable
    var representation: Name? { get }
}

extension NamedOptionSet {
    public var representation: Name? { return Name(rawValue: self.rawValue >> 1) }
    public var debugDescription: String {
        return self.representation?.stringRepresentation ?? "\(String(describing: type(of: self)))(rawValue: \(self.rawValue))"
    }
}
