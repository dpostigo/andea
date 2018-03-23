//
// Created by Daniela Postigo on 1/1/18.
//

import Foundation

#if os(iOS)

import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias LayoutPriority = UILayoutPriority
public typealias LayoutGuide = UILayoutGuide
public typealias BezierPath = UIBezierPath
public typealias Color = UIColor
public typealias Font = UIFont


#elseif os(macOS)

import AppKit
public typealias EdgeInsets = NSEdgeInsets
public typealias LayoutPriority = NSLayoutConstraint.Priority
public typealias LayoutGuide = NSLayoutGuide
public typealias BezierPath = NSBezierPath
public typealias Color = NSColor
public typealias Font = NSFont

#endif

