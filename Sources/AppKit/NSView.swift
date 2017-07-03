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

    public convenience init(color: NSColor) {
        self.init(wantsLayer: true)
        self.layer?.backgroundColor = color.cgColor
    }

    public func addView(_ view: NSView) {
        view.wantsLayer = self.wantsLayer
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }

    public func embed(_ view: NSView, insets: EdgeInsets = EdgeInsets()) {
        self.addView(view)
        self.topAnchor.constraint(equalTo: view.topAnchor, constant: -insets.top).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -insets.left).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
    }
}
