//
// Created by Daniela Postigo on 7/13/17.
//

import Foundation
import AppKit

public protocol StackController {
    var stack: NSStackView { get }
}

extension StackController where Self: NSViewController {
    public func addChildViewController(_ vc: NSViewController, in gravity: NSStackViewGravity) {
        self.addChildViewController(vc)
        self.stack.addView(vc.view, in: gravity)
    }
}

