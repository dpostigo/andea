//
// Created by Daniela Postigo on 1/4/18.
//

import UIKit
import ActionKit

public protocol Actionable { }

extension UIControl: Actionable { }

extension Actionable where Self: UIControl {
	public func addControlEvent(_ controlEvent: UIControlEvents, closure: @escaping (Self) -> Void) {
		self.addControlEvent(controlEvent, { closure(self) })
	}
}


/*
extension UIControl {
	func addControlEvent(_ controlEvent: UIControlEvents, _ closure: (() -> Void)) {
		self.addControlEvent(controlEvent, closure)
	}
}
*/