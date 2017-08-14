//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSView {
    public static var classIdentifier: String { return String(describing: self) }

    public convenience init(frame: NSRect = .zero, wantsLayer flag: Bool) {
        self.init(frame: frame); self.wantsLayer = flag
    }

    public convenience init(frame: NSRect = .zero, wantsLayer: Bool = true, canDrawSubviewsIntoLayer flag: Bool) {
        self.init(frame: frame, wantsLayer: wantsLayer); self.canDrawSubviewsIntoLayer = flag
    }

    public convenience init(autolayout flag: Bool) {
        self.init(); self.translatesAutoresizingMaskIntoConstraints = !flag
    }

    public convenience init(frame: NSRect = .zero, color: NSColor) {
        self.init(frame: frame, wantsLayer: true)
        self.layer?.backgroundColor = color.cgColor
    }

    public func addView(_ view: NSView) {
        view.wantsLayer = self.wantsLayer
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }



    public func embed(_ view: NSView, insets: NSEdgeInsets = NSEdgeInsets(), priority: NSLayoutConstraint.Priority = .required) {
        self.addView(view)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top).priority(priority).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).priority(priority).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -insets.left).priority(priority).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).priority(priority).isActive = true
    }

}


extension NSView {

//    public func embed2(_ view: NSView, insets: NSEdgeInsets = NSEdgeInsets(), priority: NSLayoutConstraint.Priority = .required) {
//        self.addView(view)
//
//        let attributes: [NSLayoutConstraint.Attribute] = [.top, .bottom, .leading, .trailing]
//        let constraints = attributes.flatMap({ self.constrain($0, view, insets, priority) })
//        NSLayoutConstraint.activate(constraints)
//    }
//
//    func constrain(_ attribute: NSLayoutConstraint.Attribute, _ view: NSView, _ insets: NSEdgeInsets = NSEdgeInsets(), _ priority: NSLayoutConstraint.Priority = .required) -> NSLayoutConstraint? {
//        switch attribute {
//            case .top: return self.topAnchor.constrain(view.topAnchor, constant: -insets.top, attribute: attribute, priority: priority)
//            case .bottom: return self.bottomAnchor.constrain(view.bottomAnchor, constant: insets.bottom, attribute: attribute, priority: priority)
//            case .leading: return self.leadingAnchor.constrain(view.leadingAnchor, constant: -insets.left, attribute: attribute, priority: priority)
//            case .trailing: return self.trailingAnchor.constrain(view.trailingAnchor, constant: insets.right, attribute: attribute, priority: priority)
//            default: return nil
//        }
//    }
}

extension NSLayoutConstraint.Attribute {

    var identifier: String { return "NSLayoutAttribute-\(self.rawValue)" }

    static func from(_ string: String) -> NSLayoutConstraint.Attribute? {
        guard let string = string.components(separatedBy: "-").last, let last = Int(string) else { return nil }
        return NSLayoutConstraint.Attribute(rawValue: last)
    }

}

extension NSView.AutoresizingMask: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard self != .none else { return ".none" }
        var ret = [String]()
        switch true {
        case self.contains(.minXMargin): ret.append("minXMargin")
        case self.contains(.width): ret.append("width")
        case self.contains(.maxXMargin): ret.append("maxXMargin")
        case self.contains(.minYMargin): ret.append("minYMargin")
        case self.contains(.height): ret.append("height")
        case self.contains(.maxYMargin): ret.append("maxYMargin")
        default: break
        }
        return (ret.map({ ".\($0)" })).joined(separator: ", ")
    }
}


//extension NSLayoutAnchor {
//    func constrain(_ anchor: NSLayoutAnchor<AnchorType>, constant: CGFloat, attribute: NSLayoutConstraint.Attribute, priority: NSLayoutConstraint.Priority = .required) -> NSLayoutConstraint {
//        let ret = self.constraint(equalTo: anchor, constant: constant)
//        ret.priority = priority
//        ret.identifier = attribute.identifier
//        return ret
//    }
//}

