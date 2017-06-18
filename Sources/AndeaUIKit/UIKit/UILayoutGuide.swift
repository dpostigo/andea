//
// Created by Dani Postigo on 11/25/16.
//

import Foundation
import UIKit

extension UILayoutGuide {
    
    public func anchor(withSubview view: UIView, insets: UIEdgeInsets? = nil) {
        view.preservesSuperviewLayoutMargins = true
        self.anchor(toViewFrame: view)
    }
    public func anchor(toViewFrame view: UIView, insets: UIEdgeInsets? = nil) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension UIView {
    
    public func anchor(_ view: UIView, layoutMargins margins: UIEdgeInsets? = nil) {
        self.addView(view)
        self.layoutMargins = margins ?? self.layoutMargins
        self.layoutMarginsGuide.anchor(withSubview: view)
    }
}
