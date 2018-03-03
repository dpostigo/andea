//
// Created by Daniela Postigo on 2/17/18.
//

import Foundation
import class Alamofire.Request

extension Alamofire.Request {
    open static func authorizationHeader(_ cred: URLCredential) -> (key: String, value: String)? {
        guard let user = cred.user, let password = cred.password else { return nil }
        return self.authorizationHeader(user: user, password: password)
    }
}