//
// Created by Daniela Postigo on 1/4/18.
//

import UIKit
import ActionKit

public enum UIGestureRecognizerKind: Int, Autorepresentable {
	case tap
	case pinch
	case rotation
	case swipe
	case pan
	case screenEdge
	case longPress
}

extension UIGestureRecognizerKind {
	public func gestureRecognizer(closure: @escaping ActionKitGestureClosure) -> UIGestureRecognizer {
		switch self {
			case .tap:			return UITapGestureRecognizer(self.stringValue, closure)
			case .pinch:        return UIPinchGestureRecognizer(self.stringValue, closure)
			case .rotation:     return UIRotationGestureRecognizer(self.stringValue, closure)
			case .swipe:        return UITapGestureRecognizer(self.stringValue, closure)
			case .pan:          return UIPanGestureRecognizer(self.stringValue, closure)
			case .screenEdge:   return UIScreenEdgePanGestureRecognizer(self.stringValue, closure)
			case .longPress:    return UILongPressGestureRecognizer(self.stringValue, closure)
		}
	}
}

extension UIView {
	public func addGestureRecognizer(_ kind: UIGestureRecognizerKind, closure: @escaping ActionKitGestureClosure) {
		self.addGestureRecognizer(kind.gestureRecognizer(closure: closure))
	}
}

extension UIBarButtonItem {

	@nonobjc public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, actionClosure closure: ActionKit.ActionKitBarButtonItemClosure) {
		self.init(barButtonSystemItem: systemItem, actionClosure: closure)
	}

	public convenience init(barButtonSystemItem systemItem: UIBarButtonSystemItem, closure: @escaping ActionKitVoidClosure) {
		self.init(barButtonSystemItem: systemItem, actionClosure: { _ in closure() })
	}
}


