//
// Created by Daniela Postigo on 6/25/17.
//

import Cocoa
import AppKit

extension NSStackView {
    public convenience init(axis: NSUserInterfaceLayoutOrientation, alignment: NSLayoutConstraint.Attribute, distribution: NSStackView.Distribution, views: [NSView] = []) {
        self.init(axis: axis, views: views)
        self.alignment = alignment
        self.distribution = distribution
    }

    public convenience init(axis: NSUserInterfaceLayoutOrientation, spacing: CGFloat = 0, distribution: NSStackView.Distribution, views: [NSView] = []) {
        self.init(axis: axis, views: views)
        self.spacing = spacing
        self.distribution = distribution
    }

    public convenience init(axis: NSUserInterfaceLayoutOrientation, edgeInsets: NSEdgeInsets = NSEdgeInsets(), views: [NSView] = []) {
        self.init(views: views)
        self.orientation = axis
        self.edgeInsets = edgeInsets
    }
}

extension NSVisualEffectView {
    public convenience init(frame: NSRect, state: NSVisualEffectView.State = .followsWindowActiveState, blendingMode: NSVisualEffectView.BlendingMode) {
        self.init(frame: frame)
        self.state = state
        self.blendingMode = blendingMode
    }


    public convenience init(state: NSVisualEffectView.State) {
        self.init(); self.state = state
    }

    public convenience init(material: NSVisualEffectView.Material, blendingMode: NSVisualEffectView.BlendingMode, state: NSVisualEffectView.State) {
        self.init()
        self.material = material
        self.blendingMode = blendingMode
        self.state = state
    }
}



extension NSCollectionView {
    public func makeItem<T: NSCollectionViewItem>(forClass type: T.Type, for indexPath: IndexPath) -> T {
        return self.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: type.classIdentifier), for: indexPath) as! T
    }
}


extension NSCollectionViewFlowLayout {
    public convenience init(scrollDirection: NSCollectionView.ScrollDirection) {
        self.init(); self.scrollDirection = scrollDirection
    }
//
//    public convenience init(scrollDirection: NSCollectionViewScrollDirection, estimatedItemSize: NSSize) {
//        self.init()
//        self.scrollDirection = scrollDirection
//        self.estimatedItemSize = estimatedItemSize
//    }

    public convenience init(scrollDirection: NSCollectionView.ScrollDirection, estimatedItemSize: NSSize = .zero, minimumLineSpacing: CGFloat = 10, minimumInteritemSpacing: CGFloat = 10) {
        self.init()
        self.scrollDirection = scrollDirection
        self.estimatedItemSize = estimatedItemSize
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
    }
}

//extension NSControl {
//    public convenience init(wantsLayer flag: Bool) {
////        self.init(wantsLayer: flag)
//         self.init(wants: Layer); self.wantsLayer = flag
//    }
//}

extension NSTextField {
//    public convenience init(wantsLayer flag: Bool) {
////        super.init(wantsLayer: flag)
//         self.init(); self.wantsLayer = flag
//    }

    public convenience init(title: String = "Title", wantsLayer: Bool = NSApplication.wantsLayer){
        self.init()
        self.stringValue = title
        self.wantsLayer = wantsLayer
    }
    public convenience init(title: String = "Title", backgroundColor: NSColor, isBordered: Bool) {
        self.init()
        self.stringValue = title
        self.backgroundColor = backgroundColor
        self.isBordered = isBordered
    }
}


extension NSTextView {
    public func scrollView(forBounds bounds: CGRect? = nil) -> NSScrollView {
        return self.configure(NSScrollView(frame: bounds ?? self.bounds))
    }
    @discardableResult public func configure(_ scrollView: NSScrollView) -> NSScrollView {
        scrollView.contentView.documentView = self
        self.isVerticallyResizable = true
        self.isHorizontallyResizable = false
        self.autoresizingMask = NSView.AutoresizingMask.width
        // self.textContainer!.widthTracksTextView = true
        return scrollView
    }

    public var scrollViewSize: CGSize {
        return CGSize(width: self.enclosingScrollView!.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    }
}


extension NSToolbar {
    public convenience init(identifier: String, delegate: NSToolbarDelegate) {
        self.init(identifier: NSToolbar.Identifier(rawValue: identifier)); self.delegate = delegate
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
        Swift.print("\(type(of: self)).\(#function)")

        self.masksToBounds = true

        self.shadowLayer.shadowOpacity = 1
        self.shadowLayer.fillColor = NSColor.clear.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
