//
//  NSLayoutConstraint.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
	
#if os(iOS)
	import UIKit
	#elseif os(macOS)
	import AppKit
#endif

extension NSLayoutConstraint {

    open class func activate(_ constraints: NSLayoutConstraint...) {
        self.activate(constraints)
    }


    @discardableResult public func identifier(_ identifier: String) -> Self {
        self.identifier = identifier
        return self
    }

    #if os(iOS)
    @discardableResult public func priority(_ priority: Float) -> Self {
        self.priority = UILayoutPriority(rawValue: priority)
        return self
    }
    @discardableResult public func priority(_ priority: UILayoutPriority) -> Self {
        self.priority = priority
        return self
    }
    #elseif os(OSX)
    @discardableResult public func priority(_ priority: NSLayoutConstraint.Priority) -> Self {
        self.priority = priority
        return self
    }
    #endif
}

extension Array where Element: NSLayoutConstraint {
    public func with(identifier: String) -> NSLayoutConstraint? {
        return self.select({ $0.identifier == identifier })
    }
}




precedencegroup LeftAssociativePrecedence {
    associativity: left
}

infix operator ⟛ : LeftAssociativePrecedence
infix operator ≃ : LeftAssociativePrecedence

//infix operator ⫩ : LeftAssociativePrecedence
// infix operator ‖ : LeftAssociativePrecedence
infix operator ⇤ : LeftAssociativePrecedence
infix operator ⇥ : LeftAssociativePrecedence


extension LayoutGuide {
    public static func ⇤(lhs: LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
        return lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor)
    }
    public static func ⇥(lhs: LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
        return lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor)
    }

}
//↔ ↹ ⇄ ⇆ ⇹ ⇿ ⇼ ⍇ ⟷ ⟺ ⃡ ⇅ ↕︎↔︎⬄ ⇔ ⬌ ⟷ ⤄
// ⥃ ⥂⥄ ⇵ ↕︎ ⇅ ⇕↕︎ ↨ ⬍⇕ ⫩⟛⟚≕
extension NSLayoutXAxisAnchor {
    public static func ⟛(lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
        return lhs.constraint(equalTo: rhs)
    }

	
    public static func ≃(lhs: NSLayoutXAxisAnchor, rhs: (NSLayoutXAxisAnchor, Float)) -> NSLayoutConstraint {
        let ret = lhs.constraint(equalTo: rhs.0)
		ret.priority = LayoutPriority(rhs.1)
		return ret
    }
}

extension NSLayoutYAxisAnchor {
    public static func ⟛(lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
        return lhs.constraint(equalTo: rhs)
    }
}


extension NSLayoutDimension {
    public static func ⟛(lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
        return lhs.constraint(equalTo: rhs)
    }

    public static func *(lhs: NSLayoutDimension, rhs: (NSLayoutDimension, CGFloat)) -> NSLayoutConstraint {
        return lhs.constraint(equalTo: rhs.0, multiplier: rhs.1)
    }
}
