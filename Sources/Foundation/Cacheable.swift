//
// Created by Daniela Postigo on 3/24/18.
//

import Foundation

public protocol Cacheable: Codable {
    static var cacheKey: String { get }
    static var prototype: Self { get }
}

extension Cacheable {
    
    public static var shared: Self {
        return self.uncached()
    }
    
    public static var cacheKey: String {
        return String(describing: self)
    }
    
    public func cache() throws {
        let data = try self.encode()
        UserDefaults.standard.set(data, forKey: Self.cacheKey)
    }
    
    public static func uncached() -> Self {
        let data = UserDefaults.standard.data(forKey: Self.cacheKey)
        switch data {
            case .none: return self.prototype
            case .some(let data) :
                let decoded = try? Self.decode(data)
                return decoded ?? self.prototype
        }
    }
   
}
