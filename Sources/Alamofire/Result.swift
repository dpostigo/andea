//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import enum Alamofire.Result
import struct Alamofire.DefaultDataResponse

extension Result {
    public typealias Item = (Result<Value>) -> Void
    public typealias Multiple = (Result<[Value]>) -> Void
}

extension DefaultDataResponse {
    public var result: Result<Bool> {
        switch self.error {
            case .none: return .success(true)
            case .some(let error): return .failure(error)
        }
    }
}

extension Decodable {
    public typealias Closure = (Self) -> Void
    public typealias Item = (Alamofire.Result<Self>) -> Void
    public typealias Multiple = (Alamofire.Result<[Self]>) -> Void
}

public struct Credential {
    public let username: String?
    public let password: String?
    public var user: String? { return self.username }
    public init(_ username: String?, _ password: String?) {
        self.username = username
        self.password = password
    }
    
    public var credential: URLCredential {
        return URLCredential(user: self.user!, password: self.password!, persistence: .none)
    }
}

extension URLCredential {
    
    public var credential: Credential {
        return Credential(self.user, self.password)
    }
}