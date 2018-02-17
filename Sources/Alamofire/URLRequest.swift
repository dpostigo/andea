//
// Created by Daniela Postigo on 2/17/18.
//

import Foundation

extension URLRequest {
    
    public subscript(field: String) -> String? {
        get { return self.value(forHTTPHeaderField: field) }
        set { self.setValue(newValue, forHTTPHeaderField: field) }
    }
    
    public subscript(field: HTTPHeader) -> String? {
        get { return self.value(forHTTPHeaderField: field.stringValue) }
        set { self.setValue(newValue, forHTTPHeaderField: field.stringValue) }
    }
}


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
