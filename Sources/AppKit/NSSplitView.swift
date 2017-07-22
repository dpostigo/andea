//
// Created by Daniela Postigo on 7/11/17.
//

import Foundation
import AppKit

extension NSSplitViewController {
    public var last: NSSplitViewItem? { return self.splitViewItems.last }
}

extension NSSplitViewItem {
    public convenience init(viewController: NSViewController, isCollapsed: Bool, canCollapse: Bool = true) {
        self.init(viewController: viewController); self.canCollapse = canCollapse; self.isCollapsed = isCollapsed
    }
}

public class ClearSplitView: NSSplitView {

    override public var dividerColor: NSColor { return NSColor.clear }
    override public var dividerThickness: CGFloat { return 0 }

    override public func drawDivider(in rect: NSRect) {
        // super.drawDivider(in: rect)
    }

}
