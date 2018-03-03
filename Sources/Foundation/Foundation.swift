//
// Created by Dani Postigo on 4/8/17.
//

import Foundation

#if os(iOS)
import UIKit
public typealias Font = UIFont
#elseif os(macOS)
import AppKit
public typealias Font = NSFont
#endif

