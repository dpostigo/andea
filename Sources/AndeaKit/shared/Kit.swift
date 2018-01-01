//
// Created by Daniela Postigo on 1/1/18.
//

import Foundation

#if os(iOS)
import UIKit
public typealias EdgeInsets = UIEdgeInsets
#elseif os(macOS)
import AppKit
public typealias EdgeInsets = NSEdgeInsets
#endif
