//
// Created by Daniela Postigo on 3/17/18.
//

import Foundation

extension Collection {
    @discardableResult
    public func some(handler: () -> Void) -> Self {
        if !self.isEmpty { handler() }
        return self
    }
    
    @discardableResult
    public func empty(handler: () -> Void) -> Self {
        if self.isEmpty { handler() }
        return self
    }
}

extension Sequence {
    
    public func element<T>(to elementType: T.Type = T.self) -> T? {
        return self.elements(to: elementType).first
    }
    
    public func elements<T>(to elementType: T.Type = T.self) -> [T] {
        return self.flatMap { $0 as? T }
    }
}
