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

    public convenience init(axis: UILayoutConstraintAxis, spacing: CGFloat = UIStackView.spacingUseSystem, views: [UIView] = [],
        alignment: UIStackViewAlignment = UIStackViewAlignment(rawValue: 0)!,
        distribution: UIStackViewDistribution = UIStackViewDistribution(rawValue: 0)!,
        preservesSuperviewLayoutMargins: Bool = false,
        isLayoutMarginsRelativeArrangement: Bool = false
    ) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
        self.addArrangedSubviews(views)
        self.preservesSuperviewLayoutMargins = preservesSuperviewLayoutMargins
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
    }

    public func addArrangedSubviews(_ views: [UIView]) {
        views.forEach(addArrangedSubview)
    }

    public func removeArrangedSubviews(_ views: [UIView]) {
        views.forEach(removeArrangedSubview)
    }
}


extension UISegmentedControl {
    public var titles: [String] {
        get { return (0 ..< self.numberOfSegments).flatMap({ self.titleForSegment(at: $0) }) }
        set {
            self.removeAllSegments()
            newValue.reversed().forEach({ self.insertSegment(withTitle: $0, at: 0, animated: false)  })
        }
    }
}