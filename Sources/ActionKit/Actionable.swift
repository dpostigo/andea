//
// Created by Daniela Postigo on 1/4/18.
//

import UIKit
import ActionKit

@objc public protocol Actionable: class { }

extension UIControl: Actionable { }


extension Actionable where Self: UIControl {
    public func addControlEvent(_ controlEvent: UIControlEvents, closure: @escaping (Self) -> Void) {
        self.addControlEvent(controlEvent, { closure(self) })
    }

    public init(_ controlEvent: UIControlEvents, handler: @escaping () -> Void) {
        self.init(); self.addControlEvent(controlEvent, handler)
    }
    
    public init(_ controlEvent: UIControlEvents, eventHandler: @escaping (Self) -> Void) {
        self.init(); self.addControlEvent(controlEvent, closure: eventHandler)
    }
	
}