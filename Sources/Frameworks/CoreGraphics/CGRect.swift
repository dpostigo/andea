//
//  CGRect.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation

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
}

extension CGRect: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = CGFloat

    public init(arrayLiteral elements: ArrayLiteralElement...) {
		precondition(elements.count == 4)
		self.init(x: elements[0], y: elements[1], width: elements[2], height: elements[3])
    }
}
