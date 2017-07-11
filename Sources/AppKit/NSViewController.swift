//
// Created by Daniela Postigo on 6/30/17.
//

import Foundation
import AppKit

extension NSViewController {
    public convenience init(view: NSView) {
        self.init(); self.view = view
    }
}


extension NSSplitViewController {
    @discardableResult public func removeSplitViewItem(at index: Int) -> NSSplitViewItem? {
        guard index < self.splitViewItems.count else { return nil }
        let item = self.splitViewItems[index]
        self.removeSplitViewItem(item)
        return item
    }
}