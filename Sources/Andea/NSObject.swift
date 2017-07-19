//
// Created by Daniela Postigo on 7/8/17.
//

import Foundation

extension Dictionary where Key == NSKeyValueChangeKey {
    public var changeType: NSKeyValueChange? {
        guard let kind = self[NSKeyValueChangeKey.kindKey] as? UInt else { return nil }
        return NSKeyValueChange(rawValue: kind)
    }

    public var newValue: Any? {
        return self[NSKeyValueChangeKey.newKey]
    }

    public var oldValue: Any? {
        return self[NSKeyValueChangeKey.oldKey]
    }

    public var indexesValue: IndexSet? {
        return self[NSKeyValueChangeKey.indexesKey] as? IndexSet
    }

    public var initialValue: Any? {
        return self [NSKeyValueChangeKey.notificationIsPriorKey]
    }
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

extension AppKit.NSViewController {


//    func valueFor(object: Any) {
//
//        if let object = object as? NSViewController, object == self {
//            let value = self.value(forKeyPath: key)
//            Swift.print("Unhandled key = \(key), value = \(value)")
//        } else {
//            Swift.print("Unhandled key = \(key)")
//        }
//    }


    public func print(unhandledKey key: String, object: Any?) {
        if let value = self.value(forUnhandled: object, keyPath: key) {
            Swift.print("Unhandled key = \(key), value = \(value)")
        } else {
            Swift.print("Unhandled key = \(key)")
        }
    }
    public func value(forUnhandled object: Any?, keyPath key: String) -> Any? {
        guard let object = object as? NSViewController, object == self else { return nil }
        return self.value(forKeyPath: key)
    }

}

