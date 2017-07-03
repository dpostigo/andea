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

    public convenience init(title: String) {
        self.init(title: title, target: nil, action: nil)
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
