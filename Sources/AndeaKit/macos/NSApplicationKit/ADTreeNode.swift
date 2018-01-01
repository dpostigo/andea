//
// Created by Daniela Postigo on 7/22/17.
//

import Foundation

@objc public class ADTreeNode: NSObject {

    @objc public var children: [Any] {
        set { self.mutableArrayValue(forKeyPath: "_children") }
        get { return self.mutableArrayValue(forKeyPath: "_children") as? [Any] ?? [] }
        //        set { self.setValue(newValue, forKey: "_children") }
        //        get { return self.value(forKey: "_children") as? [Any] ?? [] }
    }

    @objc private var _children: [Any] = []

    // MARK: Init

    init(children: [Any] = []) {
        super.init()
        //        self.children.setArray(children)

        //        let count = self.value(forKeyPath: "_children.@count")

        Swift.print("self.value(forKeyPath: \"_children.@count\") = \(String(describing: self.value(forKeyPath: "_children.@count")))")
        Swift.print("self.value(forKeyPath: \"children.@count\") = \(String(describing: self.value(forKeyPath: "children.@count")))")
    }

    // MARK: Getters

    @objc public var isLeaf: Bool {
        return self.children.isEmpty
    }

    @objc public var count: Int {
        return self.children.count
    }

    // MARK: Return values

    override public func value(forKeyPath keyPath: String) -> Any? {
        Swift.print("\(type(of: self)).\(#function), keyPath = \(keyPath)")
        return super.value(forKeyPath: keyPath)
    }

    override public func value(forKey key: String) -> Any? {
        guard !key.contains(".") else { return self.value(forKeyPath: key) }
        Swift.print("\(type(of: self)).\(#function), key = \(key)")
        return super.value(forKey: key)
    }

    override public func value(forUndefinedKey key: String) -> Any? {
        switch key {
            case "isEmpty", "isLeaf": return _children.isEmpty
            default :
                Swift.print("\(type(of: self)).\(#function), key = \(key)")
                return super.value(forUndefinedKey: key)
        }

    }

    // MARK: Set values

    override public func setValue(_ value: Any?, forKeyPath keyPath: String) {
        Swift.print("\(type(of: self)).\(#function), keyPath = \(keyPath)")
        super.setValue(value, forKeyPath: keyPath)
    }

    override public func setValue(_ value: Any?, forKey key: String) {
        Swift.print("\(type(of: self)).\(#function), key = \(key)")
        super.setValue(value, forKey: key)
    }

    override public func setValue(_ value: Any?, forUndefinedKey key: String) {
        Swift.print("\(type(of: self)).\(#function), key = \(key)")
        super.setValue(value, forUndefinedKey: key)
    }



}
