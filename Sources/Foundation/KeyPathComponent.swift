//
//  KeyPathComponent.swift
//  Pods
//
//  Created by Daniela Postigo on 8/24/17.
//

import Foundation

public enum KeyPathComponent: ExpressibleByStringLiteral, RawRepresentable {
    public typealias RawValue = String
    case index(Int)
    case string(String)
    indirect case path(KeyPathComponent, KeyPathComponent)
    
    // MARK: Init
    
    public init(stringLiteral value: String) {
        self.init(rawValue: value)!
    }
    
    public init?(rawValue: RawValue) {
        self.init(components: rawValue.components(separatedBy: "."))
    }
    
    public init?(components: [String]) {
        var components = components
        switch components.count {
        case 0: return nil
        case 1:
            if let index = components.first!.indexValue { self = .index(index) }
            else { self = .string(components.first!) }
        default :
            guard let value1 = KeyPathComponent(rawValue: components.removeFirst()) else { return nil }
            guard let value2 = KeyPathComponent(components: components) else { return nil }
            self = .path(value1, value2)
        }
    }
    
    public var rawValue: RawValue {
        switch self {
        case let .index(index): return "[\(index)]"
        case let .string(string): return string
        case let .path(first, last): return [first.rawValue, last.rawValue].joined(separator: ".")
        }
    }
}


public protocol ADKeyPathable: class { }

extension NSArray {
    open override func value(forKeyPath keyPath: String) -> Any? {
        guard self is [ADKeyPathable] else { return super.value(forKeyPath: keyPath)}
        var components = keyPath.keyPathComponents
        let first = components.removeFirst()
        switch first {
            case .index(let index):
                let object = self.object(at: index) as AnyObject
                return object.value(forComponents: components as AnyObject)
            default: return super.value(forKeyPath: keyPath)
        }
    }
}

extension NSObject {
    @objc public func value(forComponents components: AnyObject) -> Any? {
        guard let components = components as? [KeyPathComponent] else { return nil }
        return components.isEmpty ? self : self.value(forKeyPath: components.keyPath)
    }
}


extension Sequence where Element == KeyPathComponent {
    fileprivate var keyPath: String {
        return self.map({ $0.rawValue }).joined(separator: ".")
    }
    fileprivate func value(forObject object: AnyObject) -> Any? {
        return Array(self).isEmpty ? object : object.value(forKeyPath: self.keyPath)
    }
}

extension String {
    public var keyPathComponents: [KeyPathComponent] {
        return self.components(separatedBy: ".").flatMap({ KeyPathComponent(rawValue: $0) })
    }
    
    fileprivate var indexValue: Int? {
        guard self.isIndex else { return nil }
        return Int(self.dropFirst().dropLast())
    }
    
    fileprivate var isIndex: Bool {
        guard let first = self.first, let last = self.last else { return false }
        return first == "[" && last == "]"
    }
}
