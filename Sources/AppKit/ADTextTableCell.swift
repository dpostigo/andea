//
// Created by Daniela Postigo on 7/14/17.
//

import Foundation
import AppKit

open class ADTextTableCell: NSTableCellView {
    open var title = NSTextField(backgroundColor: NSColor.clear, isBordered: false)

    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = type(of: self).classIdentifier
        self.title.wantsLayer = self.wantsLayer
        self.title.controlSize = .small
        self.embed(self.title)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.title.unbind(NSValueBinding)
    }

}
