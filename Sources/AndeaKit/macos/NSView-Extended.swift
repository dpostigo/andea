//
// Created by Daniela Postigo on 9/27/17.
//

import Cocoa

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


extension NSCollectionView {
	public func makeItem<T: NSCollectionViewItem>(forClass type: T.Type, for indexPath: IndexPath) -> T {
		return self.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: type.classIdentifier), for: indexPath) as! T
	}
}

extension NSCollectionViewFlowLayout {
	public convenience init(scrollDirection: NSCollectionView.ScrollDirection) {
		self.init(); self.scrollDirection = scrollDirection
	}

	public convenience init(scrollDirection: NSCollectionView.ScrollDirection, estimatedItemSize: NSSize = .zero, minimumLineSpacing: CGFloat = 10, minimumInteritemSpacing: CGFloat = 10) {
		self.init()
		self.scrollDirection = scrollDirection
		self.estimatedItemSize = estimatedItemSize
		self.minimumLineSpacing = minimumLineSpacing
		self.minimumInteritemSpacing = minimumInteritemSpacing
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
