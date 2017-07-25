//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit
import QuartzCore

extension NSView {
    public static var classIdentifier: String { return String(describing: self) }

    public convenience init(wantsLayer flag: Bool) {
        self.init(); self.wantsLayer = flag
    }

    public convenience init(canDrawSubviewsIntoLayer flag: Bool) {
        self.init(); self.canDrawSubviewsIntoLayer = flag
    }

    public convenience init(autolayout flag: Bool) {
        self.init(); self.translatesAutoresizingMaskIntoConstraints = !flag
    }

    public convenience init(color: NSColor) {
        self.init(wantsLayer: true)
        self.layer?.backgroundColor = color.cgColor
    }

    public func addView(_ view: NSView) {
        view.wantsLayer = self.wantsLayer
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }



    public func embed(_ view: NSView, insets: EdgeInsets = EdgeInsets(), priority: NSLayoutPriority = 1000) {
        self.addView(view)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top).priority(priority).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).priority(priority).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -insets.left).priority(priority).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).priority(priority).isActive = true
    }

}


extension NSView {

    public func embed2(_ view: NSView, insets: EdgeInsets = EdgeInsets(), priority: NSLayoutPriority = 1000) {
        self.addView(view)

        let attributes: [NSLayoutAttribute] = [.top, .bottom, .leading, .trailing]
        let constraints = attributes.flatMap({ self.constrain($0, view, insets, priority) })
        NSLayoutConstraint.activate(constraints)
    }

    func constrain(_ attribute: NSLayoutAttribute, _ view: NSView, _ insets: EdgeInsets = EdgeInsets(), _ priority: NSLayoutPriority = 1000) -> NSLayoutConstraint? {
        switch attribute {
            case .top: return self.topAnchor.constrain(view.topAnchor, constant: -insets.top, attribute: attribute, priority: priority)
            case .bottom: return self.bottomAnchor.constrain(view.bottomAnchor, constant: insets.bottom, attribute: attribute, priority: priority)
            case .leading: return self.leadingAnchor.constrain(view.leadingAnchor, constant: -insets.left, attribute: attribute, priority: priority)
            case .trailing: return self.trailingAnchor.constrain(view.trailingAnchor, constant: insets.right, attribute: attribute, priority: priority)
            default: return nil
        }
    }
}

extension NSLayoutAttribute {

    var identifier: String { return "NSLayoutAttribute-\(self.rawValue)" }

    static func from(_ string: String) -> NSLayoutAttribute? {
        guard let string = string.components(separatedBy: "-").last, let last = Int(string) else { return nil }
        return NSLayoutAttribute(rawValue: last)
    }

}


extension NSLayoutAnchor {
    func constrain(_ anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat, attribute: NSLayoutAttribute, priority: NSLayoutPriority = 1000) -> NSLayoutConstraint {
        let ret = self.constraint(equalTo: anchor, constant: constant)
        ret.priority = priority
        ret.identifier = attribute.identifier
        return ret
    }
}