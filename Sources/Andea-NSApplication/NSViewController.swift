//
// Created by Daniela Postigo on 6/30/17.
//

import Foundation
import AppKit

extension NSViewController {

    public static var classIdentifier: String { return String(describing: self) }

    public convenience init(view: NSView) {
        self.init(); self.view = view
    }
    public convenience init(title: String) {
        self.init(); self.title = title
    }

    public convenience init(bounds: CGRect) {
        self.init(); self.view.bounds = bounds
    }

    public func remove(childViewController child: NSViewController?) {
        guard let child = child else { return }
        child.removeFromParentViewController()
        child.view.removeFromSuperview()
    }

    public func addChildViewControllers(_ controllers: [NSViewController]) {
        controllers.forEach({ self.addChildViewController($0) })
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
