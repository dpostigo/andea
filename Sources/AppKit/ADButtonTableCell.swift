//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import AppKit

open class ADButtonTableCell: NSTableCellView {

    @objc lazy open var button: NSButton = ({
        let button = type(of: self).create("button") as! NSButton
        button.wantsLayer = self.wantsLayer
        self.embed(button)
        return button
    })()

    override public init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = (type(of: self)).classIdentifier
        //        self.button.isBordered = false
        self.embed(self.button)
        //        self.button.bind(NSValueBinding, to: self, withKeyPath: "objectValue")
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Overrides

    override open var wantsLayer: Bool {
        didSet { self.setValue(self.wantsLayer, forKeyPath: "button.wantsLayer") }
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.button.wantsLayer = self.wantsLayer
        self.button.unbind(NSValueBinding)
    }

    // MARK: Create

    open class func create(_ property: String) -> Any? {
        switch property {
            case "button": return self.createButton()
            default : return nil
        }
    }

    open class func createButton() -> NSButton {
        let button = NSButton()
        button.bezelStyle = .texturedRounded
        return button
    }



}


extension NSView {
    func recursiveLayer() {

    }

  
}
