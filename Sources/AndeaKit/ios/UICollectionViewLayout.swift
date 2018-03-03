//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {

	public convenience init(
		scrollDirection: UICollectionViewScrollDirection,
		estimatedItemSize: CGSize = .zero,
		itemSize: CGSize = [50, 50],
		itemSpacing: CGFloat = 10,
		lineSpacing: CGFloat = 10,
		headerReferenceSize: CGSize = .zero,
		footerReferenceSize: CGSize = .zero,
		sectionInset: UIEdgeInsets = .zero,
		sectionInsetReference: UICollectionViewFlowLayoutSectionInsetReference = UICollectionViewFlowLayoutSectionInsetReference.init(rawValue: 0)!,
		sectionHeadersPinToVisibleBounds: Bool = false,
		sectionFootersPinToVisibleBounds: Bool = false
	) {
		self.init()
		self.scrollDirection = scrollDirection
		self.estimatedItemSize = estimatedItemSize
		self.minimumInteritemSpacing = itemSpacing
		self.minimumLineSpacing = lineSpacing
		self.headerReferenceSize = headerReferenceSize
		self.footerReferenceSize = footerReferenceSize
		self.sectionInset = sectionInset
		self.sectionInsetReference = sectionInsetReference
		self.sectionHeadersPinToVisibleBounds = sectionHeadersPinToVisibleBounds
		self.sectionFootersPinToVisibleBounds = sectionFootersPinToVisibleBounds
	}

	public convenience init(scrollDirection: UICollectionViewScrollDirection, estimatedItemSize: CGSize = .zero) {
		self.init()
		self.scrollDirection = scrollDirection
		self.estimatedItemSize = estimatedItemSize
	}

	// MARK: Counts

	open func number(ofItems section: Int) -> Int? {
		return self.collectionView?.numberOfItems(inSection: section)
	}

	open var numberOfSections: Int? {
		return self.collectionView?.numberOfSections
	}

	// MARK: Index paths

	open var indexPathsForSelectedItems: [IndexPath]? {
		return self.collectionView?.indexPathsForSelectedItems
	}

	open func indexPaths(in section: Int) -> [IndexPath] {
		return (0 ..< self.number(ofItems: section)!).map({ IndexPath(item: $0, section: section) })
	}

	open func register(decorationViews views: [UICollectionReusableView.Type]) {
		views.forEach({ self.register($0, forDecorationViewOfKind: $0.identifier) })
	}
}

