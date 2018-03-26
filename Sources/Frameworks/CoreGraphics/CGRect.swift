//
//  CGRect.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation

extension CGRect: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = CGFloat

    public init(arrayLiteral elements: ArrayLiteralElement...) {
		precondition(elements.count == 4)
		self.init(x: elements[0], y: elements[1], width: elements[2], height: elements[3])
    }
}
