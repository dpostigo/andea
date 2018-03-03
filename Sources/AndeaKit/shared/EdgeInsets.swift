//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation

extension EdgeInsets: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = CGFloat

    public init(arrayLiteral elements: ArrayLiteralElement...) {
	    switch elements.count {
		    // top/bottom
		    case 1: self.init(top: elements[0], left: 0, bottom: elements[0], right: 0)
		    // top/bottom, left/right
		    case 2: self.init(top: elements[0], left: elements[1], bottom: elements[0], right: elements[1])
		    // top, left/right, bottom
		    case 3: self.init(top: elements[0], left: elements[1], bottom: elements[2], right: elements[1])
		    // top, left, bottom, right
		    default:
			    precondition(elements.count == 4)
			    self.init(top: elements[0], left: elements[1], bottom: elements[2], right: elements[3])
	    }
    }
}

extension CGRect {
    public func insetBy(insets: EdgeInsets) -> CGRect {
        var rect = self.offsetBy(dx: insets.left, dy: insets.top)
        rect.size.width -= (insets.right - insets.left)
        rect.size.height -= (insets.top - insets.bottom)
        return rect
    }
    public func insetBy(amount: CGFloat) -> CGRect {
        return self.insetBy(insets: EdgeInsets(value: amount))
    }
}


extension EdgeInsets {

    public init(_ value: CGFloat) { self.init(value: value) }
	public init(value: CGFloat) {
		self.init(top: value, left: value, bottom: value, right: value)
	}

	public init(percentageOf value: CGFloat, vertical: CGFloat = 0.8, horizontal: CGFloat = 1.0) {
        self.init(top: value * vertical, left: value * horizontal, bottom: value * vertical, right: value * horizontal)
    }


    public init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }

    public init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }

    public init(top: CGFloat, bottom: CGFloat) {
        self.init(top: top, left: 0, bottom: bottom, right: 0)
    }

    public init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }


}

//extension EdgeInsets {
//
//	func test(lhs: EdgeInsets, rhs: EdgeInsets) {
//        lhs == rhs
//	}
////	public static func ==(lhs: EdgeInsets, rhs: EdgeInsets) -> Bool {
//////		return UIEdgeInsetsEqualToEdgeInsets(<#T##insets1: UIEdgeInsets##UIKit.UIEdgeInsets#>, <#T##insets2: UIEdgeInsets##UIKit.UIEdgeInsets#>)
//////		return NSEdgeInsetsEqual(lhs, rhs)
////	}
//}
//


#if os(macOS)
import AppKit

extension NSEdgeInsets: CustomDebugStringConvertible {
    public static var zero: NSEdgeInsets = NSEdgeInsetsZero
    public var debugDescription: String {
        return "(top: \(self.top), left: \(self.left), bottom: \(self.bottom), right: \(self.right))"
    }
    
    public init(top: CGFloat, left: CGFloat) {
        self.init(top: top, left: left, bottom: 0, right: 0)
    }

}



#endif
