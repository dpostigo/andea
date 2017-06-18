//
// Created by Dani Postigo on 11/23/16.
//

import Foundation

extension UserDefaults {

    public func setBool<T: RawRepresentable>(_ value: Bool, forKey type: T) where T.RawValue == String {
        self.set(value, forKey: type.rawValue)
    }

    public func set<T: RawRepresentable>(_ value: Any?, forKey type: T) where T.RawValue == String {
        guard let value = value else { self.removeObjectForKey(type); return }
        self.set(value, forKey: type.rawValue)
    }

    public func boolForKey<T: RawRepresentable>(_ type: T) -> Bool where T.RawValue == String {
        return self.bool(forKey: type.rawValue)
    }
    
    public func value<T: RawRepresentable>(forKey type: T) -> Any? where T.RawValue == String {
        return self.value(forKey: type.rawValue)
    }
    
    public func objectForKey<T: RawRepresentable>(_ type: T) -> AnyObject? where T.RawValue == String {
        return self.object(forKey: type.rawValue) as AnyObject?
    }
    
    public func removeObjectForKey<T: RawRepresentable>(_ type: T) where T.RawValue == String {
        self.removeObject(forKey: type.rawValue)
    }
}

