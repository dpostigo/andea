//
// Created by Daniela Postigo on 3/13/18.
//

import Foundation

extension Sequence {
    public typealias Handler = (Self) -> Swift.Void
}

extension NSObjectProtocol {
    public typealias Handler = (Self) -> Swift.Void
}

extension ExpressibleByNilLiteral {
    public typealias Handler = (Self) -> Swift.Void

}