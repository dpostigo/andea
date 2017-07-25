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
        title.setContentCompressionResistancePriority(1000, for: .vertical)

//        self.frame.size.height = self.contentView.fittingSize.height
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

    open var stack: NSStackView?

    // MARK: Init

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = (type(of: self)).classIdentifier

        self.embed(self.contentView)
        self.contentView.embed(self.title)

        //self.title.isHidden = true
        //        self.layout()

        self.frame.size.height = self.fittingSize.height

    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override open func layout() {
        super.layout()
        self.title.preferredMaxLayoutWidth = self.title.bounds.width

        //        Swift.print("self.fittingSize = \(self.fittingSize)")
//        Swift.print("self.contentView.fittingSize = \(self.contentView.fittingSize)")
////        self.contentView.frame = self.bounds.insetBy(insets: self.layoutMargins)
//        Swift.print("self.frame = \(self.frame)")
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach({ $0.unbind(NSValueBinding) })
        self.frame.size.height = self.fittingSize.height
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
