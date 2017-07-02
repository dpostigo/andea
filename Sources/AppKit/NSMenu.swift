//
// Created by Daniela Postigo on 6/30/17.
//

import Foundation
import AppKit

extension NSMenu {
    public convenience init(forTableView tableView: NSTableView, state: Int = 0) {
        self.init(title: tableView.autosaveName ?? "Untitled", tableColumns: tableView.tableColumns, state: state)
    }

    public convenience init(title: String, tableColumns columns: [NSTableColumn], state: Int = 0) {
        self.init(title: title)
        let items: [NSMenuItem] = columns.map({ column in
            let item = NSMenuItem(title: column.title, action: #selector(NSMenuItem.toggleState(_:)), keyEquivalent: "")
            item.target = item
            item.state = column.isHidden ? NSOffState : NSOnState
            item.onStateImage = NSImage(named: NSImageNameMenuOnStateTemplate)
            column.bind(NSHiddenBinding, to: item, withKeyPath: "state", options: [
                    NSValueTransformerBindingOption: ValueTransformer(forName: .negateBooleanTransformerName),
                    NSContinuouslyUpdatesValueBindingOption: true
            ])
            return item
        })
        items.forEach({ self.addItem($0) })
    }
}

extension NSMenuItem {
    public func toggleState(_ sender: AnyObject) {
        self.state = self.state == NSOnState ? NSOffState : NSOnState
    }
}
