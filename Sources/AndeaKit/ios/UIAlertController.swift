//
// Created by Daniela Postigo on 1/4/18.
//

import Foundation
import UIKit

extension UIAlertController {
	public convenience init(title: String?, message: String?, preferredStyle: UIAlertControllerStyle, actions: [UIAlertAction]) {
		self.init(title: title, message: message, preferredStyle: preferredStyle)
		self.addActions(actions)
	}
	
	// MARK: Utility
	
	public func addAction(_ action: UIAlertAction?) {
		guard let action = action else { return }
		self.addAction(action)
	}
	
	public func addActions( _ actions: [UIAlertAction]) {
		actions.forEach { self.addAction($0) }
	}
	
	// MARK: Creates UIAlertAction
	
	public func add(title: String?, style: UIAlertActionStyle, handler: @escaping Completion) {
        self.add(title: title, style: style) { _ in handler() }
	}
	
	public func add(title: String?, style: UIAlertActionStyle, handler: UIAlertAction.Handler? = nil) {
		self.addAction(UIAlertAction(title: title, style: style, handler: handler))
	}
}



extension Optional where Wrapped == Completion {
 
    public func converted<T>(_ parameterType: T.Type = T.self) -> ((T) -> Void)? {
		switch self {
			case .none: return nil
			case .some(let wrapped): return { _ in wrapped() }
		}
    }
}


