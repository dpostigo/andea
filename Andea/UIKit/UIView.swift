//
//  UIView.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UIView {

    public var width: CGFloat { return self.bounds.size.width }
    public var height: CGFloat { return self.bounds.size.height }

    public convenience init(color: UIColor) {
        self.init(); self.backgroundColor = color
    }

    public convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame); self.backgroundColor = color
    }

    // MARK: Methods

    public func addView(_ view: UIView, frame: CGRect = CGRect.null) {
        view.frame = frame == CGRect.null ? (view.frame == CGRect.zero ? self.bounds : view.frame) : self.bounds
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }

    public func addSubviews(_ views: [UIView]) { views.forEach({ self.addView($0) }) }
    public func removeAllSubviews() { self.subviews.forEach({ $0.removeFromSuperview() }) }

    public func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? {
        return self.constraints.with(identifier: identifier)
    }

    // MARK: Animations

    public class func animateWithDuration(_ duration: TimeInterval, options: UIViewAnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: duration, delay: 0, options: options, animations: animations, completion: completion)
    }

    // MARK: Embed

    public func embed(_ view: UIView, identifier: String) {
        self.embed(view, insets: UIEdgeInsets(), identifier: identifier)
    }

    public func embed(_ view: UIView, insets: UIEdgeInsets, identifier: String) {
        self.addView(view, frame: self.bounds)
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).identifier("\(identifier)top").isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).identifier("\(identifier)bottom").isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).identifier("\(identifier)leading").isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right).identifier("\(identifier)trailing").isActive = true
    }

    public func embed(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets()) {
        self.addView(view, frame: self.bounds)
        view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).isActive = true
        view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
        view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right).isActive = true
    }

    // MARK: Autolayout

    public var verticalResistancePriority: UILayoutPriority {
        get { return self.contentCompressionResistancePriority(for: .vertical) }
        set { self.setContentCompressionResistancePriority(newValue, for: .vertical)}
    }

    public func setResistancePriority(_ priority: UILayoutPriority, forAxis: UILayoutConstraintAxis) {
        self.setContentCompressionResistancePriority(priority, for: forAxis)
    }

    // MARK:

    func set(gesture: UIGestureRecognizer, active: Bool) {
        if active { self.addGesture(gesture) } else { self.removeGesture(gesture) }
    }

    public func addGesture(_ gesture: UIGestureRecognizer) {
        if !(self.gestureRecognizers ?? []).contains(gesture) {
            self.addGestureRecognizer(gesture)
        }
    }

    public func removeGesture(_ gesture: UIGestureRecognizer) {
        if (self.gestureRecognizers ?? []).contains(gesture) {
            self.removeGestureRecognizer(gesture)
        }
    }
}
