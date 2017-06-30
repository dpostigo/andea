//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import QuartzCore

extension NSView {

    public static var classIdentifier: String { return String(describing: self) }
//
//    public func addView(_ view: UIView, frame: CGRect = CGRect.null) {
//        view.frame = frame == CGRect.null ? (view.frame == CGRect.zero ? self.bounds : view.frame) : self.bounds
//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(view)
//    }


    public convenience init(wantsLayer: Bool) {
        self.init(); self.wantsLayer = wantsLayer
    }
//
//    public convenience init(backgroundColor: NSColor) {
//        self.init(wantsLayer: true)
//        self.view.layer?.backgroundColor = backgroundColor.cgColor
//    }

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
