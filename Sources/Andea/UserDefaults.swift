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


open class CustomDefaults<T: RawRepresentable>: UserDefaults where T.RawValue == String  {

    open func object(forKey defaultName: T) -> Any? { return self.object(forKey: defaultName.rawValue) }

    open func set(_ value: Any?, forKey defaultName: T) { self.set(value, forKey: defaultName.rawValue) }

    open func removeObject(forKey defaultName: T) { self.removeObject(forKey: defaultName.rawValue) }

    open func string(forKey defaultName: T) -> String? { return self.string(forKey: defaultName.rawValue) }

    open func array(forKey defaultName: T) -> [Any]? { return self.array(forKey: defaultName.rawValue) }

    open func dictionary(forKey defaultName: T) -> [String : Any]? { return self.dictionary(forKey: defaultName.rawValue) }

    open func data(forKey defaultName: T) -> Data? { return self.data(forKey: defaultName.rawValue) }

    open func stringArray(forKey defaultName: T) -> [String]? { return self.stringArray(forKey: defaultName.rawValue) }

    open func integer(forKey defaultName: T) -> Int { return self.integer(forKey: defaultName.rawValue) }

    open func float(forKey defaultName: T) -> Float { return self.float(forKey: defaultName.rawValue) }

    open func double(forKey defaultName: T) -> Double { return self.double(forKey: defaultName.rawValue) }

    open func bool(forKey defaultName: T) -> Bool { return self.bool(forKey: defaultName.rawValue) }

    open func url(forKey defaultName: T) -> URL? { return self.url(forKey: defaultName.rawValue) }

    open func set(_ value: Int, forKey defaultName: T) { self.set(value, forKey: defaultName.rawValue) }

    open func set(_ value: Float, forKey defaultName: T) { self.set(value, forKey: defaultName.rawValue) }

    open func set(_ value: Double, forKey defaultName: T) { self.set(value, forKey: defaultName.rawValue) }

    open func set(_ value: Bool, forKey defaultName: T) { self.set(value, forKey: defaultName.rawValue) }

    open func set(_ url: URL?, forKey defaultName: T) { self.set(url, forKey: defaultName.rawValue) }

}
