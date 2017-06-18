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
    
    mutating func with(width value: CGFloat) -> CGRect {
        self.size.width = value
        return self
    }
    public mutating func with(height value: CGFloat) -> CGRect {
        self.size.height = value
        return self
    }
}


extension CGSize {
    public init(value: CGFloat) {
        self.init(width: value, height: value)
    }
}

