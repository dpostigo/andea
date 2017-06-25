//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSTableView {
    public func removeTableColumns() {
        self.tableColumns.forEach({ self.removeTableColumn($0) })
    }
}

extension NSClipView {
    public convenience init(documentView: NSView) {
        self.init(frame: documentView.bounds)
        documentView.translatesAutoresizingMaskIntoConstraints = false
        self.documentView = documentView
        self.topAnchor.constraint(equalTo: documentView.topAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: documentView.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: documentView.trailingAnchor).isActive = true
    }
}

extension NSScrollView {

    public func enclose(view: NSView) {
        self.contentView = NSClipView(documentView: view)
    }
    private var clipView: NSClipView? {
        set {
            guard let clipView = newValue else  { return }
            clipView.translatesAutoresizingMaskIntoConstraints = false
            self.contentView = clipView
            self.topAnchor.constraint(equalTo: clipView.topAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: clipView.bottomAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: clipView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: clipView.trailingAnchor).isActive = true
        }
        get { return self.contentView }
    }
}
