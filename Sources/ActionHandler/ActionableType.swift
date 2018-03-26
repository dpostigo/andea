//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

public protocol UIActionElementProtocol: class, Hashable { }

extension UIActionElementProtocol {
    public typealias Handler = (Self) -> Void
    
    public var actionHandler: Handler? {
        get { return nil }
        set { newValue.some { ActionHandler.shared[self] = $0 } }
    }
}

extension UIBarButtonItem: UIActionElementProtocol {
    public convenience init(title: String, actionHandler: @escaping Handler) {
        self.init(title: title, style: .plain, target: nil, action: nil)
        self.actionHandler = actionHandler
    }
    
    public convenience init(image: UIImage, actionHandler: @escaping Handler) {
        self.init(image: image, style: .plain, target: nil, action: nil)
        self.actionHandler = actionHandler
    }
    
    public convenience init(image: UIImage, actionHandler: @escaping () -> Void) {
        self.init(image: image) { _ in actionHandler() }
    }
}
