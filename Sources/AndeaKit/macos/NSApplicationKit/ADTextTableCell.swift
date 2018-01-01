//
// Created by Daniela Postigo on 7/14/17.
//

import Foundation
import AppKit

open class ADTextTableCell: NSTableCellView {
    open var title = NSTextField(title: "Title", backgroundColor: NSColor.clear, isBordered: false)

    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        self.identifier = NSUserInterfaceItemIdentifier((type(of: self)).classIdentifier)
        self.title.wantsLayer = self.wantsLayer
        self.title.controlSize = .small
        self.embed(self.title)
        self.frame.size.height = self.fittingSize.height
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.title.unbind(NSBindingName.value)
    }

    override open func layout() {
        super.layout()
        self.title.preferredMaxLayoutWidth = self.title.bounds.width
    }

}
