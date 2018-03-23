//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

extension Autorepresentable {
    
    public typealias Handler = (Self) -> Void
    
    public static var first: Self {
        return self.init(rawValue: 0)!
    }
    
    public static var last: Self {
        return self.init(rawValue: Self.count - 1)!
    }
    
    public static func count(_ count: Int) -> [Self] {
        return count.times.flatMap { self.init(rawValue: $0) }
    }
    
    
    public static func +=(lhs: inout Self, rhs: Int) {
        lhs = lhs + rhs
    }
    
    public static func +(lhs: Self, rhs: Int) -> Self {
        switch lhs.rawValue + rhs {
            case let value where value < Self.count: return self.init(rawValue: value)!
            default: return Self.first
        }
    }

    
    public static var rawValues: [Self.RawValue] {
        return self.all.map { $0.rawValue }
    }
    
}