//
// Created by Daniela Postigo on 3/17/18.
//

import Foundation

extension Collection {
    @discardableResult
    public func some(handler: () -> Void) -> Self {
        if !self.isEmpty { handler() }; return self
    }
    
    @discardableResult
    public func empty(handler: () -> Void) -> Self {
        if self.isEmpty { handler() }; return self
    }
}

extension Sequence {
    
    public func element<T>(to elementType: T.Type = T.self) -> T? {
        return self.elements(to: elementType).first
    }
    
    public func elements<T>(to elementType: T.Type = T.self) -> [T] {
        return self.flatMap { $0 as? T }
    }
}


extension Sequence {
    public func dictionary<V>(_ transform: (Element) throws -> V) rethrows -> [Element: V] {
        return try Dictionary(uniqueKeysWithValues: self.map { try ($0, transform($0)) })
    }
}

extension Sequence {
    public var prettyPrinted: String { return self.string(options: .prettyPrinted)! }
    public var prettyPrintSorted: String { return self.string(options: [.prettyPrinted, .sortedKeys])! }
    private func string(options: JSONSerialization.WritingOptions) -> String? {
        return String(self, options: options)
    }
}

extension String {
    
    fileprivate init?<S: Sequence>(_ object: S, options: JSONSerialization.WritingOptions) {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: options)
            self.init(data: data, encoding: .utf8)
        } catch {
            return nil
        }
    }
}


extension RangeReplaceableCollection {
    
    public static func +(lhs: Self, rhs: Element) -> Self {
        return lhs + [rhs]
    }
}


