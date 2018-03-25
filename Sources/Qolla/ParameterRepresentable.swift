//
// Created by Daniela Postigo on 3/12/18.
//

import Foundation

public protocol ParameterRepresentable: Autorepresentable { }

extension ParameterRepresentable {
    
    public init?(rawValue: Int) {
        return nil
    }
    
    public var intValue: Int? {
        return self.rawValue
    }
    
    public var hashValue: Int {
        return self.rawValue
    }
}
