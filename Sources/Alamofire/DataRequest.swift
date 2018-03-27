//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import Alamofire

extension DataRequest {
    @discardableResult public func responseJSON(completionHandler: ((Result<Any>) -> Void)? = nil) -> Self {
        return self.responseJSON { completionHandler?($0.result) }
    }
}
