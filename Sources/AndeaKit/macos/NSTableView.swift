//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSTableView {
    public func make<T: NSTableCellView>(_ ref: T.Type, owner: Any? = nil) -> T {
        let cell: T = self.makeView(withIdentifier: T.itemIdentifier, owner: owner) as? T ?? T()
        cell.identifier = T.itemIdentifier
        cell.wantsLayer = self.wantsLayer
        return cell
    }
}

extension NSTableCellView {
    public convenience init(identifier: String) {
        self.init(); self.identifier = NSUserInterfaceItemIdentifier(rawValue: identifier)
    }
    public convenience init(itemIdentifier: NSUserInterfaceItemIdentifier) {
        self.init(); self.identifier = itemIdentifier
    }
    
    public static var itemIdentifier: NSUserInterfaceItemIdentifier {
        return NSUserInterfaceItemIdentifier(rawValue: String(describing: self))
    }
}


extension NSTableView {

    public func dequeue<T: NSTableCellView>(forClass type: T.Type) -> T {
        return self.dequeue(withIdentifier: T.classIdentifier)
    }

    public func dequeue<T: NSTableCellView>(withIdentifier identifier: String, owner: Any? = nil) -> T {
        let view: T? = self.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: identifier), owner: owner) as? T
        guard view == nil else { return view! }
        let ret = T();
        ret.wantsLayer = self.wantsLayer
        return ret
    }

    public func addTableColumns(_ columns: [NSTableColumn]) {
        columns.forEach({ self.addTableColumn($0) })
    }

    public func removeTableColumns() {
        self.tableColumns.forEach({ self.removeTableColumn($0) })
    }

    public func selectNextRow(_ extend: Bool = false) {
        guard var last = self.selectedRowIndexes.last else { return }
        last = last == self.numberOfRows - 1 ? 0 : last + 1
        self.selectRowIndexes(IndexSet(integer: last), byExtendingSelection: extend)
    }
}

extension NSTableColumn {

    public var fixedWidth: CGFloat {
        set {
            self.width = newValue
            self.minWidth = newValue
            self.maxWidth = newValue
        }
        get { return self.width }
    }

    public convenience init(identifier: String, title: String) {
        self.init(identifier: NSUserInterfaceItemIdentifier(rawValue: identifier)); self.title = title
    }

    public convenience init(identifier: String, title: String, sortDescriptor: NSSortDescriptor) {
        self.init(identifier: identifier, title: title); self.sortDescriptorPrototype = sortDescriptor
    }


    public convenience init?(properties: [NSTableColumnPropertyKey: Any]) {
        guard let identifier = properties[.identifier] as? String else { return nil }
        self.init(identifier: NSUserInterfaceItemIdentifier(rawValue: identifier))
        if let value = properties[.title] as? String {  self.headerCell.title = value }
        if let value = properties[.minWidth] as? NSNumber { self.minWidth = CGFloat(truncating: value) }
        if let value = properties[.maxWidth] as? NSNumber { self.maxWidth = CGFloat(truncating: value) }
    }
}


public typealias NSTableColumnProperty = [NSTableColumnPropertyKey: Any]

public enum NSTableColumnPropertyKey: String {
    case identifier
    case title
    case width
    case maxWidth
    case minWidth
}
