//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation

extension Mirror {
    public static func customReflect( _ value: Any) -> String {
        let mirror = Mirror(reflecting: value)
        return mirror.children.isEmpty ? String(describing: value) : String(describing: mirror.children.first!.label!)
    }
}


extension RawRepresentable {
    public var mirrorDescription: String {
        let mirror = Mirror(reflecting: self)
        return mirror.children.isEmpty ? String(describing: self) : String(describing: mirror.children.first!.label!)
    }

    public static func string(describing value: Self) -> String {
        let string = String(describing: value)
        guard string.contains("("), let index = string.index(of: "(") else { return string }
        return String(string[..<index])
        // return string.substring(to: index)
    }
}


extension Dictionary where Key: RawRepresentable, Key.RawValue == Int {
    public subscript (index: Int) -> Value? {
        get {
            guard let key = Key(rawValue: index) else { return nil }
            return self[key]
        }
        set {
            guard let key = Key(rawValue: index) else { return }
            self[key] = newValue
        }
    }
}

//extension Dictionary where Key: RawRepresentable, Key.RawValue == Int, Value : Sequence {
//
//    public subscript (row indexPath: IndexPath) -> Value.Element? {
//        let value: Value = self[indexPath.section]
//        return value[indexPath.row]
//    }
//    public subscript (item indexPath: IndexPath) -> Value.Element? {
//        return self[indexPath.section]?[indexPath.item]
//    }
//}

extension RawRepresentable where RawValue == Int {
    public static func allCases(from: Self = Self(rawValue: 0)!, to last: Self) -> [Self] {
        return (from.rawValue ..< last.rawValue + 1).flatMap({ Self(rawValue: $0 )})
    }

    //    public static func cases(to last: Self) -> [Self] {
    //        return (0 ..< last.rawValue + 1).flatMap({ Self(rawValue: $0 )})
    //    }
}

extension NSObject {
    public func setValue<T: RawRepresentable>(_ value: Any?, forKey key: T) where T.RawValue == String {
        self.setValue(value, forKey: key.rawValue)
    }

    public func value<T: RawRepresentable>(forKey key: T) -> Any? where T.RawValue == String {
        return self.value(forKey: key.rawValue)
    }
}


extension Sequence where Self.Iterator.Element: RawRepresentable {
    public var rawValues: [Self.Iterator.Element.RawValue] {
        return self.map({ $0.rawValue })
    }
}


extension Array {
    public subscript<T: RawRepresentable>(representable: T) -> Element where T.RawValue == Int {
        get { return self[representable.rawValue] }
        set { self[representable.rawValue] = newValue }
    }
}


extension IndexPath {
    public init<T: RawRepresentable>(row: Int, section: T) where T.RawValue == Int {
        self.init(row: row, section: section.rawValue)

    }
}


