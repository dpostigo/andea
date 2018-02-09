//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation


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




