//
// Created by Daniela Postigo on 6/25/17.
//

import Cocoa
import AppKit

extension NSArrayController {
    public var indexes: IndexSet {
        return (self.arrangedObjects as! [Any]).indexSet
    }

    public func setSelectedSymmetricDifference(withIndexes indexes: IndexSet? = nil) {
        let selected = indexes ?? self.selectionIndexes
        let indexes = self.indexes.symmetricDifference(selected)
        self.setSelectionIndexes(indexes)
    }

    public convenience init(automaticallyRearrangesObjects: Bool, selectsInsertedObjects: Bool = false) {
        self.init(); self.automaticallyRearrangesObjects = automaticallyRearrangesObjects; self.selectsInsertedObjects = selectsInsertedObjects
    }
}

extension NSStackView {
    public convenience init(axis: NSUserInterfaceLayoutOrientation, alignment: NSLayoutAttribute, distribution: NSStackViewDistribution, views: [NSView] = []) {
        self.init(axis: axis, views: views)
        self.alignment = alignment
        self.distribution = distribution
    }

    public convenience init(axis: NSUserInterfaceLayoutOrientation, spacing: CGFloat = 0, distribution: NSStackViewDistribution, views: [NSView] = []) {
        self.init(axis: axis, views: views)
        self.spacing = spacing
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

