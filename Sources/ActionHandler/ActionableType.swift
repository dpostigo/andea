//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

public protocol ActionableType: class, Hashable { }

extension ActionableType {
    public typealias Handler = (Self) -> Void
    
    public var actionHandler: Handler? {
        get { return nil }
        set { newValue.some { ActionHandler.shared[self] = $0 } }
    }
}

extension UIBarButtonItem: ActionableType { }
