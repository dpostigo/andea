//
// Created by Daniela Postigo on 3/17/18.
//

import Foundation

extension Sequence where Element: Hashable {
    public var unique: [Element] {
        return Set<Element>(self).array
    }
}


extension Sequence {
    public var array: [Element] {
        return Array(self)
    }
    public func all(_ body: (Self.Element) throws -> Bool) rethrows -> Bool {
        return try self.filter { try body($0) == false }.count > 0
    }
}
