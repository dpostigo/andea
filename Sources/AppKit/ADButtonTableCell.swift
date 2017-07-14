//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import AppKit

open class ADButtonTableCell: NSTableCellView {


    lazy open var button: NSButton = ({
        let button = NSButton()
        button.wantsLayer = self.wantsLayer
        button.bezelStyle = .texturedRounded
//        button.title = "Button"
        self.embed(button)
        return button
    })()

    // let button = NSButton(image: NSImage(named: NSImageNameGoRightTemplate)!)

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = (type(of: self)).classIdentifier
        //        self.button.isBordered = false
        self.embed(self.button)
        //        self.button.bind(NSValueBinding, to: self, withKeyPath: "objectValue")
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.button.unbind(NSValueBinding)
    }

}
