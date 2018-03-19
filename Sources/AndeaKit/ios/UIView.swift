//
//  UIView.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit
import QuartzCore

extension UIView {
    @nonobjc public static var identifier: String {
        return String(describing: self)
    }

	// MARK: Convenience properties

    public var width: CGFloat { return self.bounds.size.width }
    public var height: CGFloat { return self.bounds.size.height }
	public var stackView: UIStackView? { return self.superview as? UIStackView }

	public var hideSubviews: Bool {
		get { return false }
		set { self.subviews.forEach({ $0.isHidden = newValue }) }
	}

    public var borderColor: UIColor? {
        get  { return self.layer.borderColor == nil ? nil : UIColor(cgColor: self.layer.borderColor!) }
        set {
            self.layer.borderColor = newValue?.cgColor
            self.layer.borderWidth = 1 / UIScreen.main.scale
        }
    }

    public var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }

    public var border: (UIColor?, CGFloat) {
        get { return (self.borderColor, self.borderWidth) }
        set { self.borderColor = newValue.0; self.borderWidth = newValue.1 }
    }

	public var shouldRasterize: Bool {
		get { return self.layer.shouldRasterize }
		set { self.layer.rasterizationScale = UIScreen.main.nativeScale; self.layer.shouldRasterize = newValue }
	}

    public var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }


    // MARK: View hierarchy

    public func addSubviews(_ views: [UIView]) {
        views.forEach({ self.addView($0) })
    }

    public func removeAllSubviews() {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }

    // MARK: Autolayout / Autolayout priority helpers

    public var verticalResistancePriority: UILayoutPriority {
        get { return self.contentCompressionResistancePriority(for: .vertical) }
        set { self.setContentCompressionResistancePriority(newValue, for: .vertical)}
    }

    public var verticalContentHuggingPriority: UILayoutPriority {
        get { return self.contentHuggingPriority(for: .vertical) }
        set { self.setContentHuggingPriority(newValue, for: .vertical)}
    }

    // MARK: Autolayout / Priority items

    public typealias UILayoutPriorityItem = (UIViewContentLayoutPriority, UILayoutConstraintAxis, UILayoutPriority)

    public enum UIViewContentLayoutPriority {
        case compression, hugging
    }

    public var priorities: [UILayoutPriorityItem]? {
        get { return nil }
        set { self.update(priorities: newValue) }
    }

    public func setPriorityItems(_ priorities: UILayoutPriorityItem...) {
        self.priorities = priorities
    }

    private func update(priorities: [UILayoutPriorityItem]?) {
        guard let items = priorities else { return }
        items.forEach({
            switch $0.0 {
                case .compression: self.setContentCompressionResistancePriority($0.2, for: $0.1)
                case .hugging: self.setContentHuggingPriority($0.2, for: $0.1)
            }
        })
    }


	public var compression: (UILayoutConstraintAxis, UILayoutPriority)? {
		get { return nil }
		set { self.update(compression: newValue) }
	}

	private func update(compression: (UILayoutConstraintAxis, UILayoutPriority)?) {
		guard let compression = compression else { return }
		self.setCompression(compression)
	}

    public func setCompression( _ items: (UILayoutConstraintAxis, UILayoutPriority)...) {
	    items.forEach({ self.setContentCompressionResistancePriority($0.1, for: $0.0) })
    }

	public var hugging: (UILayoutConstraintAxis, UILayoutPriority)? {
		get { return nil }
		set { self.update(hugging: newValue) }
	}

	private func update(hugging: (UILayoutConstraintAxis, UILayoutPriority)?) {
		guard let hugging = hugging else { return }
		self.setHugging(hugging)
	}

	public func setHugging( _ items: (UILayoutConstraintAxis, UILayoutPriority)...) {
		items.forEach({ self.setContentHuggingPriority($0.1, for: $0.0) })
	}

    // MARK: Autolayout / Autolayout helpers
    
    public convenience init(systemLayoutHeight view: UIView) {
        self.init(frame: view.bounds)
        self.sizeToSystemLayoutHeight(to: view)
    }
    
    @discardableResult
    public func sizeToSystemLayoutHeight(to view: UIView) -> UIView {
        let size = self.systemLayoutSizeFitting(
            view.bounds.size,
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        self.frame.size.height = size.height
        return self
    }
    
    public func systemLayoutHeight(_ frame: CGRect) -> CGFloat {
        return self.systemLayoutHeight(frame.size)
    }

    public func systemLayoutHeight(_ size: CGSize) -> CGFloat {
        return self.systemLayoutSizeFitting(size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
    }

	public var safe: UILayoutGuide {
		return self.safeAreaLayoutGuide
	}

	public var margins: UILayoutGuide {
		return self.layoutMarginsGuide
	}

    // MARK: Initializers

    public convenience init(color: UIColor) {
        self.init(); self.backgroundColor = color
    }
    public convenience init(tintColor: UIColor) {
        self.init(); self.tintColor = tintColor
    }

    public convenience init(frame: CGRect, color: UIColor) {
        self.init(frame: frame); self.backgroundColor = color
    }
    public convenience init(height: CGFloat) {
        self.init(); self.frame.size.height = height
    }


    // MARK: Methods

	public func addView(_ view: UIView, frame: CGRect = CGRect.null) {
		view.frame = frame == CGRect.null ? (view.frame == CGRect.zero ? self.bounds : view.frame) : self.bounds
		view.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(view)
	}

	public func addViews(_ views: UIView...) {
		views.forEach{ self.addView($0) }
	}

   public func constraintWithIdentifier(_ identifier: String) -> NSLayoutConstraint? { return self.constraints.with(identifier: identifier) }

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

	public func embed(_ view: UIView, insets: UIEdgeInsets) {
	// public func embed(_ view: UIView, insets: UIEdgeInsets = UIEdgeInsets()) {
        self.addView(view, frame: self.bounds)

        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                self.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -insets.top),
                self.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: insets.bottom),
                self.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: -insets.left),
                self.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: insets.right),
            ])
        } else {
            view.topAnchor.constraint(equalTo: self.topAnchor, constant: insets.top).isActive = true
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -insets.bottom).isActive = true
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: insets.left).isActive = true
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -insets.right).isActive = true

        }
    }

    @discardableResult public func embed(_ view: UIView) -> [NSLayoutConstraint] {
        return self.embed(view, from: self.layoutMarginsGuide, to: view.safeAreaLayoutGuide)
    }

    @discardableResult public func embed(_ view: UIView, from: UILayoutGuide) -> [NSLayoutConstraint] {
        return self.embed(view, from: from, to: view.safeAreaLayoutGuide)
    }


    @discardableResult public func embed(_ view: UIView, from: UILayoutGuide, to: UILayoutGuide) -> [NSLayoutConstraint] {
        let constraints = self.constraints(view, from: from, to: to)
        NSLayoutConstraint.activate(constraints)
        return constraints
    }

    @discardableResult public func constraints(_ view: UIView, from: UILayoutGuide) -> [NSLayoutConstraint] {
        return self.constraints(view, from: from, to: view.safeAreaLayoutGuide)
    }

    @discardableResult public func constraints(_ view: UIView, from: UILayoutGuide, to: UILayoutGuide) -> [NSLayoutConstraint] {
        self.addView(view, frame: from.layoutFrame)
        let constraints = [
            from.topAnchor.constraint(equalTo: to.topAnchor),
            from.bottomAnchor.constraint(equalTo: to.bottomAnchor),
            from.leadingAnchor.constraint(equalTo: to.leadingAnchor),
            from.trailingAnchor.constraint(equalTo: to.trailingAnchor),
        ]
        return constraints
    }


    public func embed(_ view: UIView, from: UILayoutGuide, to: UILayoutGuide, priority: (top: Float, left: Float, bottom: Float, right: Float)? = nil) {
        self.addView(view, frame: from.layoutFrame)

        if let priority = priority {
            NSLayoutConstraint.activate([
                from.topAnchor.constraint(equalTo: to.topAnchor).priority(priority.top),
                from.bottomAnchor.constraint(equalTo: to.bottomAnchor).priority(priority.bottom),
                from.leadingAnchor.constraint(equalTo: to.leadingAnchor).priority(priority.left),
                from.trailingAnchor.constraint(equalTo: to.trailingAnchor).priority(priority.right),
            ])
        } else {
            NSLayoutConstraint.activate([
                from.topAnchor.constraint(equalTo: to.topAnchor),
                from.bottomAnchor.constraint(equalTo: to.bottomAnchor),
                from.leadingAnchor.constraint(equalTo: to.leadingAnchor),
                from.trailingAnchor.constraint(equalTo: to.trailingAnchor),
            ])
        }

    }

    // MARK: Gestures

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
    
    public func removeGestures() {
        self.gestures.forEach { self.removeGestureRecognizer($0) }
    }
    
    public var gestures: [UIGestureRecognizer] {
        return self.gestureRecognizers ?? []
    }
    
    open class func animate(
        _ duration: TimeInterval,
        delay: TimeInterval,
        options: UIViewAnimationOptions = [],
        animations: @escaping () -> Swift.Void,
        completion: ((Bool) -> Swift.Void)? = nil
    ) {
        self.animate(withDuration: duration, delay: delay, options: options, animations: animations, completion: completion)
    }
}



public class LineBackgroundView: UIView  {
    public var strokeColor: UIColor = UIColor.darkGray
    public var lineWidth: CGFloat = 1 / UIScreen.main.scale


    public var edge: UIRectEdge = .bottom

    public var usesSafeAreaInsets = false


    public convenience init(edge: UIRectEdge = .bottom, color: UIColor, usesSafeAreaInsets: Bool = false) {
        self.init(); self.edge = edge; self.strokeColor = color; self.usesSafeAreaInsets = usesSafeAreaInsets
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.isOpaque = false
        self.preservesSuperviewLayoutMargins = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        let marginsArea = (self.usesSafeAreaInsets ? self.safeAreaLayoutGuide : self.layoutMarginsGuide).layoutFrame

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setLineWidth(self.lineWidth)
        context.setStrokeColor(self.strokeColor.cgColor)

        switch true {
            case self.edge.contains(.bottom):
                context.move(to: CGPoint(x: marginsArea.minX, y: self.bounds.maxY))
                context.addLine(to: CGPoint(x: marginsArea.maxX, y: self.bounds.maxY))

            case self.edge.contains(.top):
                context.move(to: CGPoint(x: marginsArea.minX, y: marginsArea.minY))
                context.addLine(to: CGPoint(x: marginsArea.maxX, y: marginsArea.minY))

            default: break
        }
        context.strokePath()
    }

}


extension UIActivityIndicatorView {

	public convenience init(frame: CGRect = .zero, isAnimating: Bool) {
		self.init(frame: frame)
		guard isAnimating else { return }
		self.startAnimating()
	}
}
