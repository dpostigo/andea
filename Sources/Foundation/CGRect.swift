//
//  CGRect.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation

extension CGFloat {

    public static var zero: CGFloat { return 0 }
}

extension CGSize {
    public init(value: CGFloat) {
        self.init(width: value, height: value)
    }
}

extension CGRect {
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



#if os(OSX)
extension CGRect {
    public func insetBy(insets: NSEdgeInsets) -> CGRect {
        var rect = self.offsetBy(dx: insets.left, dy: insets.top)
        rect.size.width -= (insets.right - insets.left)
        rect.size.height -= (insets.top - insets.bottom)
        return rect
    }
    public func insetBy(amount: CGFloat) -> CGRect {
        return self.insetBy(insets: NSEdgeInsets(value: amount))
    }
}
#endif



