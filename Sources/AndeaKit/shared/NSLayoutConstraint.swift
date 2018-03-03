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


// infix operator &= : LeftAssociativePrecedence    // constraint(equalTo:)
infix operator &=+ : LeftAssociativePrecedence      // constraint(equalTo:constant:)
infix operator &=* : LeftAssociativePrecedence      // constraint(equalTo:multiplier:)
infix operator &~= : LeftAssociativePrecedence      // constraint(equalTo:) with priority

extension NSLayoutXAxisAnchor {
	public static func &=(lhs: NSLayoutXAxisAnchor, rhs: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs)
	}
	public static func &~=(lhs: NSLayoutXAxisAnchor, rhs: (NSLayoutXAxisAnchor, Float)) -> NSLayoutConstraint {
		let ret = lhs.constraint(equalTo: rhs.0); ret.priority = LayoutPriority(rhs.1); return ret
	}
	public static func &=+(lhs: NSLayoutXAxisAnchor, rhs: (NSLayoutXAxisAnchor, CGFloat)) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs.0, constant: rhs.1)
	}
}

extension NSLayoutYAxisAnchor {
	public static func &=(lhs: NSLayoutYAxisAnchor, rhs: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs)
	}
	public static func &=+(lhs: NSLayoutYAxisAnchor, rhs: (NSLayoutYAxisAnchor, CGFloat)) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs.0, constant: rhs.1)
	}
}


extension NSLayoutDimension {
	public static func &=(lhs: NSLayoutDimension, rhs: NSLayoutDimension) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs)
	}
	public static func &=*(lhs: NSLayoutDimension, rhs: (NSLayoutDimension, CGFloat)) -> NSLayoutConstraint {
		return lhs.constraint(equalTo: rhs.0, multiplier: rhs.1)
	}

}


infix operator &=< : LeftAssociativePrecedence // leading
infix operator &=> : LeftAssociativePrecedence // trailing
infix operator &^= : LeftAssociativePrecedence // top
infix operator &=^ : LeftAssociativePrecedence // bottom
infix operator &=- : LeftAssociativePrecedence // centerY
infix operator &<> : LeftAssociativePrecedence // leading + trailing
//infix operator &= : LeftAssociativePrecedence


extension LayoutGuide {

	// MARK: Convenience getters 
	
	open var leading: NSLayoutXAxisAnchor   { return self.leadingAnchor }
	open var trailing: NSLayoutXAxisAnchor  { return self.trailingAnchor }
	open var centerX: NSLayoutXAxisAnchor   { return self.centerXAnchor }
	open var top: NSLayoutYAxisAnchor       { return self.topAnchor }
	open var bottom: NSLayoutYAxisAnchor    { return self.bottomAnchor }
	open var centerY: NSLayoutYAxisAnchor   { return self.centerYAnchor }
	open var width: NSLayoutDimension       { return self.widthAnchor }
	open var height: NSLayoutDimension      { return self.heightAnchor }

	// MARK: Operators
	
	public static func &=<(lhs:LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
		return lhs.leadingAnchor.constraint(equalTo: rhs.leadingAnchor)
	}

	public static func &=>(lhs:LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
		return lhs.trailingAnchor.constraint(equalTo: rhs.trailingAnchor)
	}

    public static func &^=(lhs:LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
        return lhs.topAnchor.constraint(equalTo: rhs.topAnchor)
    }

	public static func &=-(lhs:LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
		return lhs.centerYAnchor.constraint(equalTo: rhs.centerYAnchor)
	}

    public static func &=^(lhs:LayoutGuide, rhs: LayoutGuide) -> NSLayoutConstraint {
        return lhs.bottomAnchor.constraint(equalTo: rhs.bottomAnchor)
    }

	public static func &<>(lhs:LayoutGuide, rhs: LayoutGuide) -> [NSLayoutConstraint] {
        return [lhs &=< rhs, lhs &=> rhs]
	}
}
//↔ ↹ ⇄ ⇆ ⇹ ⇿ ⇼ ⍇ ⟷ ⟺ ⃡ ⇅ ↕︎↔︎⬄ ⇔ ⬌ ⟷ ⤄
// ⥃ ⥂⥄ ⇵ ↕︎ ⇅ ⇕↕︎ ↨ ⬍⇕ ⫩⟛⟚≕⟝⟞


extension Array where Iterator.Element == NSLayoutConstraint {
    public func activate() {
        NSLayoutConstraint.activate(self)
    }
}
