//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import enum Alamofire.Result

extension Result {
    public typealias Item = (Result<Value>) -> Void
    public typealias Multiple = (Result<[Value]>) -> Void
}
