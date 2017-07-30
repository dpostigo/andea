//
// Created by Dani Postigo on 11/23/16.
//

import Foundation


extension UserDefaults {

    public convenience init(suiteName: String, initialValues: [String: Any]?) {
        self.init(suiteName: suiteName)!
        guard !self.initialized, let values = initialValues else { return }
        self.setValuesForKeys(values)
        self.initialized = true
    }

    open var initialized: Bool {
        get { return self.bool(forKey: "initialized") }
        set { self.set(newValue, forKey: "initialized") }
    }
}


extension UserDefaults {

    open var keys: [String] {
        return Array(self.dictionaryRepresentation().keys)
    }

    open var keysRepresentation: String {
        let data = try! JSONSerialization.data(withJSONObject: self.keys.sorted(), options: .prettyPrinted)
        return String(data: data, encoding: .utf8)!
    }

    public func boolForKey<T: RawRepresentable>(_ type: T) -> Bool where T.RawValue == String {
        return self.bool(forKey: type.rawValue)
    }

    public func setBool<T: RawRepresentable>(_ value: Bool, forKey type: T) where T.RawValue == String {
        self.set(value, forKey: type.rawValue)
    }


    public func set<T: RawRepresentable>(_ value: Any?, forKey type: T) where T.RawValue == String {
        guard let value = value else { self.removeObjectForKey(type); return }
        self.set(value, forKey: type.rawValue)
    }

    public func objectForKey<T: RawRepresentable>(_ type: T) -> AnyObject? where T.RawValue == String {
        return self.object(forKey: type.rawValue) as AnyObject?
    }
    
    public func removeObjectForKey<T: RawRepresentable>(_ type: T) where T.RawValue == String {
        self.removeObject(forKey: type.rawValue)
    }
}

