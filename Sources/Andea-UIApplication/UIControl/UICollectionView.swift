//
//  UICollectionView.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit


extension UICollectionView {

    public enum ElementKind: String {
        case header
        case footer

        public var rawValue: String {
            switch self {
                case .header: return UICollectionElementKindSectionHeader
                case .footer: return UICollectionElementKindSectionFooter
            }
        }
    }

    public func register(_ viewClass: Swift.AnyClass?, forSupplementaryViewOfKind kind: ElementKind, withReuseIdentifier identifier: String) {
        self.register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: identifier)
    }

    public func scrollToItemAtIndexPath(_ indexPath: IndexPath, atScrollPosition scrollPosition: UICollectionViewScrollPosition, completion: ((Bool) -> Void)? = nil) {
        if let cell = self.cellForItem(at: indexPath) {
            let point = self.pointForRect(cell.frame.offsetBy(dx: -self.contentInset.left, dy: -self.contentInset.top), atScrollPosition: scrollPosition)
            UIView.animate(withDuration: 0.4, animations: { self.contentOffset = point }, completion: completion)
        }
    }

    fileprivate func pointForRect(_ rect: CGRect, atScrollPosition scrollPosition: UICollectionViewScrollPosition) -> CGPoint {
        switch scrollPosition {
            case UICollectionViewScrollPosition.top: return CGPoint(x: rect.minX, y: rect.minY)
            case UICollectionViewScrollPosition.centeredVertically: return CGPoint(x: rect.minX, y: rect.midY)
            case UICollectionViewScrollPosition.bottom: return CGPoint(x: rect.minX, y: rect.maxY)
            case UICollectionViewScrollPosition.left: return CGPoint(x: rect.minX, y: rect.minY)
            case UICollectionViewScrollPosition.centeredHorizontally: return CGPoint(x: rect.midX, y: rect.minY)
            case UICollectionViewScrollPosition.right: return CGPoint(x: rect.maxX, y: rect.minY)
            default: return self.contentOffset
        }
    }
}

extension UICollectionViewController {
	var collection: UICollectionView { return self.collectionView! }
}

extension UICollectionViewFlowLayout {
    public convenience init(scrollDirection: UICollectionViewScrollDirection) {
        self.init()
        self.scrollDirection = scrollDirection
    }
    public convenience init(scrollDirection: UICollectionViewScrollDirection, estimatedItemSize: CGSize) {
        self.init()
        self.scrollDirection = scrollDirection
        self.estimatedItemSize = estimatedItemSize
    }
}
