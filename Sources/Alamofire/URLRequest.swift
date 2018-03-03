//
// Created by Daniela Postigo on 2/17/18.
//

import Foundation

extension URLRequest {
    public subscript(field: String) -> String? {
        get { return self.value(forHTTPHeaderField: field) }
        set { self.setValue(newValue, forHTTPHeaderField: field) }
    }
}

extension HTTPURLResponse {
    public subscript(field: AnyHashable) -> Any? {
        return self.allHeaderFields[field]
    }
}