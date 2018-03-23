//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

extension Range where Bound: Strideable  {
    
    public static func +(lhs: Range<Bound>, rhs: Bound) -> Bound {
        switch rhs {
            case lhs.upperBound: return lhs.lowerBound
            default: return rhs.advanced(by: 1)
        }
    }
}
