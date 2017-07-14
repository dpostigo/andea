//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import AppKit

open class ADTableCellView: NSTableCellView {

    lazy open var contentView: NSView = ({ NSView(wantsLayer: self.wantsLayer) })()

    lazy open var title: NSTextField = ({
        let title = NSTextField(wantsLayer: self.wantsLayer)
        //self.textField = title
        // title.controlSize = .small
        title.cell?.isBezeled = true
        title.bezelStyle = .roundedBezel
        // title.cell?.controlSize = .small
        self.contentView.embed(title)
        return title
    })()

    lazy open var subtitle: NSTextField = ({
        let subtitle = NSTextField(wantsLayer: self.wantsLayer)
        self.contentView.embed(subtitle)
        return subtitle
    })()


    open var layoutMargins: EdgeInsets = EdgeInsets() {
        didSet { self.setNeedsDisplay(self.bounds) }
    }

    // MARK: Init

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = (type(of: self)).classIdentifier
        self.embed(self.title)
//        self.contentView = self
        // self.embed(self.contentView)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override open func layout() {
        super.layout()

//        Swift.print("self.fittingSize = \(self.fittingSize)")
//        Swift.print("self.contentView.fittingSize = \(self.contentView.fittingSize)")
////        self.contentView.frame = self.bounds.insetBy(insets: self.layoutMargins)
//        Swift.print("self.frame = \(self.frame)")
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach({ $0.unbind(NSValueBinding) })
    }

    private func update(margins: EdgeInsets) {
        Swift.print("self.contentView.constraints = \(self.contentView.constraints)")
    }

}


extension EdgeInsets {

    public func value(for attribute: NSLayoutAttribute)  -> CGFloat {
        switch attribute {
            case .top : return self.top
            case .bottom : return self.bottom
            case .left, .leading : return self.left
            case .right, .trailing : return self.right
            default : return 0
        }
    }
}
