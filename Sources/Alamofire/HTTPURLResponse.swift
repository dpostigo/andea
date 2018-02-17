//
// Created by Daniela Postigo on 2/17/18.
//

import Foundation

extension HTTPURLResponse {
    
    public subscript(field: AnyHashable) -> Any? {
        return self.allHeaderFields[field]
    }
    
    public subscript(field: HTTPHeader) -> String? {
        return self[field.stringValue] as? String
    }
    
    public var authorization: String? {
        guard let token = self[.authorization] else { return nil }
        guard let range = token.range(of: "Bearer ") else { return nil }
        return String(token[range.upperBound...])
    }
}