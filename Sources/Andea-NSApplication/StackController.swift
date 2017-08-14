//
// Created by Daniela Postigo on 7/13/17.
//

import Foundation
import AppKit

public protocol StackController {
    var stack: NSStackView { get }
}

extension StackController where Self: NSViewController {
    public func addChildViewController(_ vc: NSViewController, in gravity: NSStackView.Gravity) {
        self.addChildViewController(vc)
        self.stack.addView(vc.view, in: gravity)
    }
}

open class ADStackViewController: NSViewController, StackController {
    open var stack = NSStackView(axis: .vertical)
    
    override open func loadView() {
        self.view = NSView(wantsLayer: NSApplication.wantsLayer)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.embed(self.stack)
    }
}
