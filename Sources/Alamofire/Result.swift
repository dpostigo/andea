//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import enum Alamofire.Result
import struct Alamofire.DefaultDataResponse


extension Decodable {
    public typealias Item = (Alamofire.Result<Self>) -> Void
    public typealias Multiple = (Alamofire.Result<[Self]>) -> Void
}
enum ResultError: Swift.Error { case noValue }
extension Result {
  
    public typealias Item = (Result<Value>) -> Void
    public typealias Multiple = (Result<[Value]>) -> Void

    public static func from(_ value: Value, _ error: Error?) -> Result {
        return Result(value, error)
    }
    
    public static func from(_ value: Value?, _ error: Error?) -> Result {
        switch error {
            case .none: return value.result
            case .some(let error): return .failure(error)
        }
    }
    
    init(_ value: Value, _ error: Error?) {
        switch error {
            case .none: self = .success(value)
            case .some(let error): self = .failure(error)
        }
    }
}

extension Optional {
    var result: Result<Wrapped> {
        switch self {
            case .none: return .failure(ResultError.noValue)
            case .some(let value): return .success(value)
        }
    }
}
extension DefaultDataResponse {
    public var result: Result<Bool> {
        switch self.error {
            case .none: return .success(true)
            case .some(let error): return .failure(error)
        }
    }
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
