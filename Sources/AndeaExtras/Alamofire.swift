//
// Created by Daniela Postigo on 6/21/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    @discardableResult public func responseJSON(completion: ((Any) -> Void)? = nil, failure: ((Error) -> Void)? = nil) -> Self {
        return self.responseJSON(completionHandler: { response in
            switch response.result {
                case .success(let value): completion?(value)
                case .failure(let error): failure?(error)
            }
        })
    }
}


//public func request(_ request: URLRequestConvertible, completion: ((Any) -> Void)? = nil, failure: Failure? = nil) -> DataRequest {
//    let ret = Alamofire.request(request)
//    ret.responseJSON(completion: completion, failure: failure)
//    return ret
//}
