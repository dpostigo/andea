//
//  UIStackView.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UIStackView {
    public convenience init(axis: UILayoutConstraintAxis) {
        self.init(); self.axis = axis
    }

    public convenience init(axis: UILayoutConstraintAxis, views: [UIView]) {
        self.init(axis: axis)
        self.addArrangedSubviews(views)
    }

    public convenience init(axis: UILayoutConstraintAxis, spacing: CGFloat) {
        self.init(axis: axis)
        self.spacing = spacing
    }

    public convenience init(axis: UILayoutConstraintAxis, spacing: CGFloat, alignment: UIStackViewAlignment) {
        self.init(axis: axis, spacing: spacing); self.alignment = alignment
    }
    
    public convenience init(axis: UILayoutConstraintAxis, alignment: UIStackViewAlignment) {
        self.init(axis: axis); self.alignment = alignment
    }
    public convenience init(axis: UILayoutConstraintAxis, alignment: UIStackViewAlignment, distribution: UIStackViewDistribution) {
        self.init(axis: axis, alignment: alignment); self.distribution = distribution
    }
    
    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }

    public func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach(removeArrangedSubview)
    }
}
