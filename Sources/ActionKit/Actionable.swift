//
// Created by Daniela Postigo on 1/4/18.
//

import UIKit
import ActionKit

public protocol ActionKitProtocol: class {
    init()
}

extension UIButton: ActionKitProtocol { }
extension UITextField: ActionKitProtocol { }
extension UIRefreshControl: ActionKitProtocol { }
extension UISegmentedControl: ActionKitProtocol { }


extension ActionKitProtocol {
    
    public typealias Handler = (Self) -> Void
    
    public init(_ controlEvent: UIControlEvents, handler: @escaping () -> Void) {
        self.init(); self.addControlEvent(controlEvent, handler: handler)
    }
    
    public init(_ controlEvent: UIControlEvents, actionHandler: @escaping (Self) -> Void) {
        self.init(); self.addControlEvent(controlEvent, actionHandler: actionHandler)
    }
    
    public func addControlEvent(_ controlEvent: UIControlEvents, handler: @escaping () -> Void) {
        switch self as? UIControl {
            case .some(let value): value.addControlEvent(controlEvent, { handler() })
            default: break
        }
    }
    
    public func addControlEvent(_ controlEvent: UIControlEvents, actionHandler: @escaping (Self) -> Void) {
        switch self as? UIControl {
            case .some(let value): value.addControlEvent(controlEvent, { actionHandler(self) })
            default: break
        }
    }
}

