//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSStackView {
    public convenience init(axis: NSUserInterfaceLayoutOrientation, views: [NSView]) {
        self.init(views: views)
        self.orientation = axis
    }
}

extension NSButton {
    public convenience init(image: NSImage) {
        self.init(image: image, target: nil, action: nil)
    }
}

extension NSTextField {
    public convenience init(backgroundColor: NSColor, isBordered: Bool) {
        self.init()
        self.backgroundColor = backgroundColor
        self.isBordered = isBordered
    }
}
