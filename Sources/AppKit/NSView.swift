//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit
import QuartzCore

extension NSView {

    public static var classIdentifier: String { return String(describing: self) }

    public convenience init(wantsLayer: Bool) {
        self.init(); self.wantsLayer = wantsLayer
    }

    public convenience init(color: NSColor) {
        self.init(wantsLayer: true)
        self.layer?.backgroundColor = color.cgColor
    }

    public func addView(_ view: NSView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
    }

    public func embed(_ view: NSView) {
        self.addView(view)
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}
