//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation

extension RawRepresentable {
    public static func string(describing value: Self) -> String {
        let string = String(describing: value)
        guard string.contains("("), let index = string.index(of: "(") else { return string }
        return String(string[..<index])
        // return string.substring(to: index)
    }
}


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