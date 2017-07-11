//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSStackView {
    public convenience init(axis: NSUserInterfaceLayoutOrientation, alignment: NSLayoutAttribute, distribution: NSStackViewDistribution, views: [NSView] = []) {
        self.init(axis: axis, views: views)
        self.alignment = alignment
        self.distribution = distribution
    }

    public convenience init(axis: NSUserInterfaceLayoutOrientation, views: [NSView] = []) {
        self.init(views: views)
        self.orientation = axis
    }
}

extension NSButton {
    public convenience init(image: NSImage) {
        self.init(image: image, target: nil, action: nil)
    }

    public convenience init(title: String) {
        self.init(title: title, target: nil, action: nil)
    }

    public func toggleState(_ sender: Any? = nil) {
        self.state = self.state == NSOnState ? NSOffState : NSOnState
    }
}


extension NSTextField {
    public convenience init(wantsLayer flag: Bool) {
        self.init(); self.wantsLayer = flag
    }

    public convenience init(backgroundColor: NSColor, isBordered: Bool) {
        self.init()
        self.backgroundColor = backgroundColor
        self.isBordered = isBordered
    }
}


extension NSToolbar {
    public convenience init(identifier: String, delegate: NSToolbarDelegate) {
        self.init(identifier: identifier); self.delegate = delegate
    }
}

