//
// Created by Daniela Postigo on 6/30/17.
//

import Foundation
import AppKit

extension NSMenu {

    public var fileMenu: NSMenu? {
        return self.fileItem?.submenu
    }
    public var fileItem: NSMenuItem? {
        return self.item(withTitle: "File")
    }

    public convenience init(forTableView tableView: NSTableView, state: Int = 0) {
        self.init(title: tableView.autosaveName.map { $0.rawValue } ?? "Untitled", tableColumns: tableView.tableColumns, state: state)
    }

    
    public func addItem(title: String, action: Selector? = nil, keyEquivalent: String = "") {
        self.addItem(withTitle: title, action: action, keyEquivalent: keyEquivalent)
    }
    
     public convenience init(title: String, tableColumns columns: [NSTableColumn], state: Int = 0) {
        self.init(title: title)
        let items: [NSMenuItem] = columns.map({ column in
            let item = NSMenuItem(title: column.title, action: #selector(NSMenuItem.toggleState(_:)), keyEquivalent: "")
            item.target = item
            item.state = column.isHidden ? NSControl.StateValue.offState : NSControl.StateValue.onState
            item.onStateImage = NSImage(named: NSImage.Name.menuOnStateTemplate)
            column.bind(NSBindingName.hidden, to: item, withKeyPath: "state", options: [
                    NSBindingOption.valueTransformer: ValueTransformer(forName: .negateBooleanTransformerName)!,
                    NSBindingOption.continuouslyUpdatesValue: true
            ])
            return item
        })
        items.forEach({ self.addItem($0) })
    }
}

extension NSMenuItem {
    
    public convenience init(title: String, action: Selector? = nil, keyEquivalent: String = "") {
        self.init(title: title, action: action, keyEquivalent: keyEquivalent)
    }
    @objc public func toggleState(_ sender: AnyObject) {
        self.state = self.state == NSControl.StateValue.onState ? NSControl.StateValue.offState : NSControl.StateValue.onState
    }
}
