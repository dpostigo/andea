//
// Created by Daniela Postigo on 1/1/18.
//

import Foundation

#if os(iOS)

import UIKit
public typealias EdgeInsets = UIEdgeInsets
public typealias LayoutPriority = UILayoutPriority
public typealias LayoutGuide = UILayoutGuide


#elseif os(macOS)

import AppKit
public typealias EdgeInsets = NSEdgeInsets
public typealias LayoutPriority = NSLayoutConstraint.Priority
public typealias LayoutGuide = NSLayoutGuide

#endif

