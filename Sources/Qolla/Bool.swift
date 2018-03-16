//
// Created by Daniela Postigo on 3/16/18.
//

import Foundation

extension Bool: Comparable {
    public var intValue: Int { return self == true ? 1 : 0 }
    public static func <(lhs: Bool, rhs: Bool) -> Bool {
        return lhs.intValue < rhs.intValue
    }
}

