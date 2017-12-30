//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation

@objc public class ValueWrapper: NSObject {
    @objc public var value: Any? {
        set { self.setValue(newValue, forKey: "_value") }
        get { return self.value(forKey: "_value")}
    }

    @objc private var _value: Any?

    public init(value: Any? = nil) {
        super.init()
        self.value = value
    }
}

public enum KVError: Error {
    case keyNotFound(String)
}

@objc public class KVPair: NSObject, NSCopying {
    @objc public let key: String
    @objc public var value: Any?

    // MARK: Init

    public required init(key: String, value: Any? = nil){
        self.key = key; self.value = value; super.init()
    }

    public convenience init<T: RawRepresentable>(key: T, value: Any? = nil) where T.RawValue == String {
        self.init(key: key.rawValue, value: value)
    }

    // MARK: NSCopying

    public func copy(with zone: NSZone?) -> Any {
        return type(of: self).init(key: self.key, value: self.value)
    }
}

public func ==(lhs: KVPair, rhs: KVPair) -> Bool {
    return lhs.key == rhs.key
}

public protocol KVPairable {
    var kvPair: KVPair { get }
    var rawValue: String { get }
}

@objc public class KVCollection: NSObject {
    @objc public var items: [KVPair] = []

    // MARK: Init

    public init(items: [KVPair] = []) {
        self.items = items
        super.init()
    }

    public convenience init(items: KVPair...) {
        self.init(items: items)
    }

    public convenience init<T: KVPairable>(items: T...) where T: RawRepresentable, T.RawValue == String {
        self.init(items: items.kvPairs)
    }

    // MARK: Overrides

    override open func value(forUndefinedKey key: String) -> Any? {
        switch key {
            case "items": break
            default : return self.items.select({ $0.key == key })
        }

        return super.value(forUndefinedKey: key)
    }

    public func values(forKeys keys: String...) throws -> [Any?] {
        return try self.elements(forKeys: keys).values
    }

    public func elements(forKeys keys: String ...) throws -> [KVPair] {
         return try self.elements(forKeys: keys)
    }

    public func elements(forKeys keys: [String]) throws -> [KVPair] {
        return try self.items.elements(forKeys: keys).flatMap({ $0 })
    }

    // MARK: KVPairable

    public func value<T: KVPairable>(_ key: T) throws -> Any? {
        return try self.items.element(forKey: key).value
    }

    public func values<T: KVPairable>(forKeys keys: T...) throws -> [Any?] {
        return try self.elements(forKeys: keys).values
    }

    public func elements<T: KVPairable>(forKeys keys: T...) throws -> [KVPair] {
        return try self.elements(forKeys: keys)
    }

    public func elements<T: KVPairable>(forKeys keys: [T]) throws -> [KVPair] {
        return try self.elements(forKeys: keys.map({ $0.rawValue }))
    }



}

// MARK: Collection helpers


extension Sequence where Self.Iterator.Element == KVPair {

    public subscript(key: String) -> Any? {
        set { try? self.element(forKey: key).value = newValue }
        get { return (try? self.element(forKey: key))?.value }
    }

    public var values: [Any?] { return self.map({ $0.value }) }

    public func element(forKey key: String) throws -> Iterator.Element {
        guard let element = self.select({ $0.key == key }) else { throw KVError.keyNotFound(key) }
        return element
    }

    public func element<T: KVPairable>(forKey key: T) throws -> Iterator.Element {
        return try self.element(forKey: key.rawValue)
    }

    public func elements(forKeys keys: String ...) throws -> [Iterator.Element] {
        return try self.elements(forKeys: keys)
    }

    public func elements(forKeys keys: [String]) throws -> [Iterator.Element] {
        return try keys.map({ try self.element(forKey: $0) })
    }


}


//extension Sequence where Self.Iterator.Element: NSObject {
//    public func element(withValue value: Any, forKey key: String) -> Iterator.Element? {
//        return self.select({ element in
//            guard let elementValue = element.value(forKeyPath: key) else { return false }
//            return elementValue == value
////            return element.value(forKeyPath: key) == value
////            return element.value(forKey: key) == value
//        })
//    }
//}


extension Sequence where Self.Iterator.Element: KVPairable {
    public var kvPairs: [KVPair] { return self.map({ $0.kvPair }) }
}
