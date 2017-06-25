//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation

extension NSView {
//
//    public func addView(_ view: UIView, frame: CGRect = CGRect.null) {
//        view.frame = frame == CGRect.null ? (view.frame == CGRect.zero ? self.bounds : view.frame) : self.bounds
//        view.translatesAutoresizingMaskIntoConstraints = false
//        self.addSubview(view)
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
