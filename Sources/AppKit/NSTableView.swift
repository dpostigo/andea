//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSTableCellView {
    public convenience init(wantsLayer: Bool) {
        self.init(); self.wantsLayer = wantsLayer
    }
}

extension NSTableView {

    public func dequeue<T: NSTableCellView>(forClass type: T.Type) -> T {
        return self.dequeue(withIdentifier: T.classIdentifier)
    }

    public func dequeue<T: NSTableCellView>(withIdentifier identifier: String) -> T {
        let view: T? = self.make(withIdentifier: identifier, owner: self) as? T
        guard view == nil else { return view! }
        let ret = T(); ret.wantsLayer = true; return ret
    }

    public func addTableColumns(_ columns: [NSTableColumn]) {
        columns.forEach({ self.addTableColumn($0) })
    }

    public func removeTableColumns() {
        self.tableColumns.forEach({ self.removeTableColumn($0) })
    }
}

extension NSTableColumn {

    public convenience init?(identifier: String, title: String) {
        self.init(identifier: identifier)
        self.title = title
    }
    public convenience init?(properties: [NSTableColumnPropertyKey: Any]) {
        guard let identifier = properties[.identifier] as? String else { return nil }
        self.init(identifier: identifier)
        if let value = properties[.title] as? String {  self.headerCell.title = value }
        if let value = properties[.minWidth] as? NSNumber { self.minWidth = CGFloat(value) }
        if let value = properties[.maxWidth] as? NSNumber { self.maxWidth = CGFloat(value) }
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
