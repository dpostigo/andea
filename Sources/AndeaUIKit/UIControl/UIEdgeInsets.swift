//
//  UIEdgeInsets.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation

extension UIEdgeInsets {
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