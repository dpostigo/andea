//
// Created by Daniela Postigo on 3/9/18.
//

import Foundation

extension NSObjectProtocol {
    
    @discardableResult
    public func `as`<T>(_ type: T.Type = T.self, handler: (T) -> Void) -> Self {
        if let value = self as? T { handler(value) }
        return self
    }
    
    @discardableResult
    public func `is`<T>(_ type: T.Type = T.self, handler: (T) -> Void) -> Self {
        if let value = self as? T { handler(value) }
        return self
    }
    
    @discardableResult
    public func not<T>(_ type: T.Type = T.self, handler: (Self) -> Void) -> Self {
        if self as? T == nil { handler(self) }
        return self
    }
}
