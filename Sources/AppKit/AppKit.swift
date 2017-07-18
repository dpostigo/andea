//
// Created by Daniela Postigo on 6/25/17.
//

import Cocoa
import AppKit

extension NSObjectController {
    public var contentArray: [Any]? {
        return self.content as? [Any]
    }
}

extension NSTreeController {
    public var arrangedArray: [Any]? { return self.arrangedObjects as? [Any] }
}
extension NSArrayController {
    public var indexes: IndexSet {
        return (self.arrangedObjects as! [Any]).indexSet
    }

    public convenience init(automaticallyRearrangesObjects: Bool, selectsInsertedObjects: Bool = false) {
        self.init(); self.automaticallyRearrangesObjects = automaticallyRearrangesObjects; self.selectsInsertedObjects = selectsInsertedObjects
    }

    public func value(forKeyPath keyPath: String, at index: Int) -> Any? {
        return self.object(at: index)?.value(forKeyPath: keyPath)
    }

    public func object(at index: Int) -> NSObject? {
        return self.value(at: index) as? NSObject
    }

    public func value(at index: Int) -> Any? {
        return (self.arrangedObjects as! [Any])[index]
    }

    public func setSelectedSymmetricDifference(withIndexes indexes: IndexSet? = nil) {
        let selected = indexes ?? self.selectionIndexes
        let indexes = self.indexes.symmetricDifference(selected)
        self.setSelectionIndexes(indexes)
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

extension NSCollectionView {
    public func makeItem<T: NSCollectionViewItem>(forClass type: T.Type, for indexPath: IndexPath) -> T {
        return self.makeItem(withIdentifier: type.classIdentifier, for: indexPath) as! T
    }
}


extension NSCollectionViewFlowLayout {
    public convenience init(scrollDirection: NSCollectionViewScrollDirection) {
        self.init(); self.scrollDirection = scrollDirection
    }
//
//    public convenience init(scrollDirection: NSCollectionViewScrollDirection, estimatedItemSize: NSSize) {
//        self.init()
//        self.scrollDirection = scrollDirection
//        self.estimatedItemSize = estimatedItemSize
//    }

    public convenience init(scrollDirection: NSCollectionViewScrollDirection, estimatedItemSize: NSSize = .zero, minimumLineSpacing: CGFloat = 10, minimumInteritemSpacing: CGFloat = 10) {
        self.init()
        self.scrollDirection = scrollDirection
        self.estimatedItemSize = estimatedItemSize
        self.minimumLineSpacing = minimumLineSpacing
        self.minimumInteritemSpacing = minimumInteritemSpacing
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


extension NSTextView {
    public func scrollView(forBounds bounds: CGRect? = nil) -> NSScrollView {
        return self.configure(NSScrollView(frame: bounds ?? self.bounds))
    }
    @discardableResult public func configure(_ scrollView: NSScrollView) -> NSScrollView {
        scrollView.contentView.documentView = self
        self.isVerticallyResizable = true
        self.isHorizontallyResizable = false
        self.autoresizingMask = .viewWidthSizable
        // self.textContainer!.widthTracksTextView = true
        return scrollView
    }

    public var scrollViewSize: CGSize {
        return CGSize(width: self.enclosingScrollView!.bounds.width, height: CGFloat.greatestFiniteMagnitude)
    }
}


extension NSToolbar {
    public convenience init(identifier: String, delegate: NSToolbarDelegate) {
        self.init(identifier: identifier); self.delegate = delegate
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
