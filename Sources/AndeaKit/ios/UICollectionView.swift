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

    open func register(_ cells: UICollectionViewCell.Type...) {
        self.register(cells)
    }

    open func register(_ cells: [UICollectionViewCell.Type]) {
        cells.forEach { self.register($0, forCellWithReuseIdentifier: $0.identifier) }
    }

    open func dequeueReusableCell<C: UICollectionViewCell>(_ cellClass: C.Type = C.self, for indexPath: IndexPath) -> C {
        return self.dequeueReusableCell(withReuseIdentifier: cellClass.identifier, for: indexPath) as! C
    }

    // MARK: Supplementary views


//    open func register(_ elementKind: String, _ headers: [UICollectionReusableView.Type]) {
//        headers.forEach { self.register($0, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: $0.identifier) }
//    }

//	open func register(_ elementKind: String = UICollectionElementKindSectionHeader, _ headers: UICollectionReusableView.Type...) {
//		self.register(elementKind, headers)
//	}

    open func register<C: UICollectionReusableView>(
        _ viewClass: C.Type = C.self,
        forElementKind elementKind: String = UICollectionElementKindSectionHeader
    ) {
        self.register(
            viewClass,
            forSupplementaryViewOfKind: elementKind,
            withReuseIdentifier: viewClass.identifier
        )
    }
	
    open func dequeueReusableSupplementaryView<C: UICollectionReusableView>(_ viewClass: C.Type = C.self, for indexPath: IndexPath, elementKind: String = UICollectionElementKindSectionHeader) -> C {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: viewClass.identifier, for: indexPath) as! C
    }
    //    open func register(_ headers: UITableViewHeaderFooterView.Type...) {
//        self.register(headers)
//    }


}

extension UICollectionView {
    public var flow: UICollectionViewFlowLayout? {
        return self.collectionViewLayout as? UICollectionViewFlowLayout
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

extension UICollectionView {
    public enum ElementKind: String {
        case cell
        case header
        case footer

        public var rawValue: String {
            switch self {
				case .cell: return ""
                case .header: return UICollectionElementKindSectionHeader
                case .footer: return UICollectionElementKindSectionFooter
            }
        }
    }

    public func register<T: UICollectionReusableView>(_ viewClass: T.Type, forElementKind kind: ElementKind) {
        switch kind {
            case .cell: self.register(viewClass, forCellWithReuseIdentifier: viewClass.identifier)
            case .header, .footer: self.register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.identifier)
        }
    }

    public func register(_ viewClass: Swift.AnyClass?, forSupplementaryViewOfKind kind: ElementKind, withReuseIdentifier identifier: String) {
        self.register(viewClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: identifier)
    }
}

extension UICollectionViewController {
	public var collection: UICollectionView { return self.collectionView! }

    public var flow: UICollectionViewFlowLayout? {
        return self.collectionViewLayout as? UICollectionViewFlowLayout
    }

    public func collectionViewLayout<T: UICollectionViewLayout>(ofClass layoutClass: T.Type = T.self) -> T? {
        return self.collectionViewLayout as? T
    }

}




extension UICollectionReusableView {

    public static func preferred(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        return self.init().preferredLayoutAttributesFitting(layoutAttributes)
    }
}
