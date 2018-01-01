//
// Created by Daniela Postigo on 7/12/17.
//

import Cocoa

open class ADTableCellView: NSTableCellView {

    lazy open var contentView: NSView = ({
        return NSView(wantsLayer: self.wantsLayer)
    })()

    lazy open var title: NSTextField = ({
        var title = NSTextField(wantsLayer: true)
        //self.textField = title
        title.cell?.isBezeled = true
        title.bezelStyle = .roundedBezel
        title.setContentCompressionResistancePriority(.required, for: .vertical)
        return title
    })()

    lazy open var subtitle: NSTextField = ({
        let subtitle = NSTextField()
        subtitle.wantsLayer = true
        self.contentView.embed(subtitle)
        return subtitle
    })()


    open var layoutMargins: NSEdgeInsets = NSEdgeInsets() {
        didSet { self.setNeedsDisplay(self.bounds) }
    }

    open var stack: NSStackView?

    // MARK: Init

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.identifier = type(of: self).itemIdentifier
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
    }

    override open func prepareForReuse() {
        super.prepareForReuse()
        self.contentView.subviews.forEach({ $0.unbind(NSBindingName.value) })
        self.frame.size.height = self.fittingSize.height
    }

    private func update(margins: NSEdgeInsets) {
        Swift.print("self.contentView.constraints = \(self.contentView.constraints)")
    }

}


extension NSEdgeInsets {

    public func value(for attribute: NSLayoutConstraint.Attribute)  -> CGFloat {
        switch attribute {
            case .top : return self.top
            case .bottom : return self.bottom
            case .left, .leading : return self.left
            case .right, .trailing : return self.right
            default : return 0
        }
    }
}
