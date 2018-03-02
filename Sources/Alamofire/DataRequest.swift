//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import Alamofire

extension DataRequest {
    
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
