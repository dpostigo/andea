//
// Created by Daniela Postigo on 7/17/17.
//

import Cocoa
import QuartzCore

extension CALayer {
    public convenience init(frame: CGRect) {
        self.init(); self.frame = frame
    }
}


open class Background: NSView {
    private let maskLayer: CAShapeLayer = CAShapeLayer()
    private static let layerHeight: CGFloat = 5

    // MARK: Init

    public override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)

        self.wantsLayer = true
        self.layer!.backgroundColor = NSColor.clear.cgColor

        self.maskLayer.fillColor = NSColor.clear.cgColor
        self.maskLayer.backgroundColor = NSColor.clear.cgColor
        self.layer!.addSublayer(self.maskLayer)

        self.shadowOpacity = 0.5
        self.shadowColor = NSColor.black.cgColor

        self.shadowRadius = 1
        self.shadowOffset = CGSize(width: 0, height: 1)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Layout

    override open var isFlipped: Bool {
        return true
    }

    override open func layout() {
        super.layout()
        guard self.maskLayer.frame != self.bounds else { return }
        self.maskLayer.shadowPath = CGPath(rect: self.layerRect, transform: nil)
        self.maskLayer.frame = self.bounds
    }

    // MARK: Private

    private var layerRect: NSRect {
        var rect = self.bounds.offsetBy(dx: 0, dy: -type(of: self).layerHeight)
        rect.size.height = type(of: self).layerHeight
        return rect
    }

    // MARK: Helpers

    func update(shadow: NSShadow) {
        self.maskLayer.shadowRadius = shadow.shadowBlurRadius
        self.maskLayer.shadowOffset = shadow.shadowOffset
        self.maskLayer.shadowColor = shadow.shadowColor?.cgColor
    }

    // MARK: Getters

    open var shadowColor: CGColor? {
        set { self.maskLayer.shadowColor = newValue }
        get { return self.maskLayer.shadowColor }
    }

    open var shadowRadius: CGFloat {
        set { self.maskLayer.shadowRadius = newValue }
        get { return self.maskLayer.shadowRadius }
    }

    open var shadowOffset: CGSize {
        set { self.maskLayer.shadowOffset = newValue }
        get { return self.maskLayer.shadowOffset }
    }

    open var shadowOpacity: Float {
        set { self.maskLayer.shadowOpacity = newValue }
        get { return self.maskLayer.shadowOpacity }
    }
}


class ShadowLayer: CALayer {

    private let shadowLayer = CAShapeLayer()


    override open var backgroundColor: CGColor? {
        didSet {

        }
    }


    override var shadowColor: CGColor? {
        set {
            self.shadowLayer.strokeColor = self.shadowColor
            self.shadowLayer.shadowColor = self.shadowColor
        }
        get { return self.shadowLayer.shadowColor }
    }

    override var shadowRadius: CGFloat {
        didSet {
            self.shadowLayer.shadowRadius = self.shadowRadius
            self.shadowLayer.shadowOffset = CGSize(width: 0, height: self.shadowRadius * 2)

        }
    }

    override init(layer: Any) {
        super.init(layer: layer)
        Log.print("\(type(of: self)).\(#function)")

        self.masksToBounds = true

        self.shadowLayer.shadowOpacity = 1
        self.shadowLayer.fillColor = NSColor.clear.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
