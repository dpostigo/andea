//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import class Alamofire.Request

// MARK: HTTPHeader

public enum HTTPHeader: Int, CodingKey {
    case authorization
    case contentType
    
    public var stringValue: String {
        switch self {
            case .contentType: return "Content-Type"
            default: return self.name.capitalized
        }
    }
}

extension URLRequest {
    public subscript(field: HTTPHeader) -> String? {
        get { return self.value(forHTTPHeaderField: field.stringValue) }
        set { self.setValue(newValue, forHTTPHeaderField: field.stringValue) }
    }
    
    public mutating func withAuthorization(handler: () -> String) -> URLRequest {
        self[.authorization] = handler()
        return self
    }
    
    public mutating func withAuthorization(handler: () -> URLCredential) -> URLRequest {
        return self.withAuthorization { Request.authorizationHeader(handler()) }
    }
    
    public mutating func withAuthorization(handler: () -> (key: String, value: String)?) -> URLRequest {
        switch handler() {
            case .none: break
            case .some(let value): self[.authorization] = value.value
        }
        return self
    }

}


extension HTTPURLResponse {
    public subscript(field: HTTPHeader) -> String? {
        return self[field.stringValue] as? String
    }
    
    public var authorization: String? {
        guard let token = self[.authorization] else { return nil }
        guard let range = token.range(of: "Bearer ") else { return nil }
        return String(token[range.upperBound...])
    }
}



