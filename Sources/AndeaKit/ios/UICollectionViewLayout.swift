//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {
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

