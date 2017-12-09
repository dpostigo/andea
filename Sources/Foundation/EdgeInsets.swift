//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit

extension UIEdgeInsets {

    public init(_ value: CGFloat) {
        self.init(value: value)
    }

    public init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
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
#elseif os(OSX)
import AppKit

extension NSEdgeInsets: CustomDebugStringConvertible {
    public static var zero: NSEdgeInsets = NSEdgeInsetsZero
    public var debugDescription: String {
        return "(top: \(self.top), left: \(self.left), bottom: \(self.bottom), right: \(self.right))"
    }
    
    public init(top: CGFloat, bottom: CGFloat) {
        self.init(top: top, left: 0, bottom: bottom, right: 0)
    }

    public init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }

    public init(top: CGFloat, left: CGFloat) {
        self.init(top: top, left: left, bottom: 0, right: 0)
    }

    public init(value: CGFloat) {
        self.init(top: value, left: value, bottom: value, right: value)
    }
}

public func ==(lhs: NSEdgeInsets, rhs: NSEdgeInsets) -> Bool {
    return NSEdgeInsetsEqual(lhs, rhs)
}

#endif
