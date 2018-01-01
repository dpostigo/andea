//
// Created by Daniela Postigo on 7/8/17.
//

import Foundation

extension NSObject {
    
    // MARK: Bindings info
    
    #if os(OSX)
    open func info(_ binding: NSBindingName, forKey key: NSBindingInfoKey) -> Any? {
        return self.infoForBinding(binding)?[key]
    }
    #endif

    open func array(forKeyPath keyPath: String) -> [Any]? {
        return self.value(forKeyPath: keyPath) as? [Any]
    }

    open func dictionaryWithValues(forKeyPaths keyPaths: String...) -> [String : Any] {
        return self.dictionaryWithValues(forKeyPaths: keyPaths)
    }
    
    open func stringWithValues(forKeyPaths keyPaths: String...) -> String {
        return JSONSerialization.string(self.dictionaryWithValues(forKeyPaths: keyPaths))
    }
    
    private func dictionaryWithValues(forKeyPaths keyPaths: [String]) -> [String : Any] {
        var ret = [String: Any]()
        keyPaths.forEach({ ret[$0] = self.value(forKeyPath: $0) })
        return ret
    }
}


extension Dictionary where Key == NSKeyValueChangeKey {
    public var changeType: NSKeyValueChange? {
        guard let kind = self[NSKeyValueChangeKey.kindKey] as? UInt else { return nil }
        return NSKeyValueChange(rawValue: kind)
    }

    public var newValue: Any? { return self[NSKeyValueChangeKey.newKey] }
    public var oldValue: Any? { return self[NSKeyValueChangeKey.oldKey] }
    public var indexesValue: IndexSet? { return self[NSKeyValueChangeKey.indexesKey] as? IndexSet }
    public var initialValue: Any? { return self [NSKeyValueChangeKey.notificationIsPriorKey] }
}

extension NSKeyValueChange {
    public var stringValue: String {
        switch self {
            case .insertion : return "insertion"
            case .removal : return "removal"
            case .setting : return "setting"
            case .replacement : return "replacement"
        }
    }
}

extension NSObject {
    // MARK: Debug

    public func print(unhandledKey key: String, object: Any?) {
        if let value = self.value(forUnhandled: object, keyPath: key) {
            Swift.print("Unhandled key = \(key), value = \(value)")
        } else {
            Swift.print("Unhandled key = \(key)")
        }
    }
    public func value(forUnhandled object: Any?, keyPath key: String) -> Any? {
        guard let object = object as? NSObject, object == self else { return nil }
        return self.value(forKeyPath: key)
    }
}
