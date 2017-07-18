//
//  CGRect.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation

extension EdgeInsets {
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

extension CGRect {

    public func insetBy(amount: CGFloat) -> CGRect {
        return self.insetBy(insets: EdgeInsets(value: amount))
    }

    public func insetBy(insets: EdgeInsets) -> CGRect {
        var rect = self.offsetBy(dx: insets.left, dy: insets.top)
        rect.size.width -= (insets.right - insets.left)
        rect.size.height -= (insets.top - insets.bottom)
        return rect
    }

    public init(width: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: width)
    }
    public init(width: CGFloat, height: CGFloat) {
        self.init(x: 0, y: 0, width: width, height: height)
    }
    public init(size: CGSize) {
        self.init(origin: CGPoint.zero, size: size)
    }

    public init(origin: CGPoint, width: CGFloat, height: CGFloat) {
        self.init(x: origin.x, y: origin.y, width: width, height: height)
    }
    
    public mutating func setWidth(_ value: CGFloat) -> CGRect {
        self.size.width = value
        return self
    }
    public mutating func setHeight(_ value: CGFloat) -> CGRect {
        self.size.height = value
        return self
    }
}


extension CGSize {
    public init(value: CGFloat) {
        self.init(width: value, height: value)
    }
}

