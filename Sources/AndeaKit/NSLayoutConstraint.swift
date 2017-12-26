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


