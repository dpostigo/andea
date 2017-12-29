//
// Created by Daniela Postigo on 6/21/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import Alamofire

extension HTTPURLResponse {
    public var authorization: String? {
        guard let headers = self.allHeaderFields as? [String: Any], let token = headers["Authorization"] as? String else {
            return nil
        }
        return AuthorizationHeader(string: token).bearer?.string
    }
}


extension Alamofire.DataRequest {

    @discardableResult public func responseJSON(completion: ((JSON) -> Void)? = nil, failure: ((Error) -> Void)? = nil) -> Self {
        return self.responseJSON(completionHandler: { response in
            switch response.result {
                case .success(let value): completion?(value as! JSON)
                case .failure(let error): failure?(error)
            }
        })
    }

    @discardableResult public func responseJSON(completion: ((Any) -> Void)? = nil, failure: ((Error) -> Void)? = nil) -> Self {
        return self.responseJSON(completionHandler: { response in
            switch response.result {
                case .success(let value): completion?(value)
                case .failure(let error): failure?(error)
            }
        })
    }
}

