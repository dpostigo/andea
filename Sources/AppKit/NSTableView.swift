//
// Created by Daniela Postigo on 6/25/17.
//

import Foundation
import AppKit

extension NSTableView {
    public func addTableColumns(_ columns: [NSTableColumn]) {
        columns.forEach({ self.addTableColumn($0) })
    }

    public func removeTableColumns() {
        self.tableColumns.forEach({ self.removeTableColumn($0) })
    }
}

extension NSTableColumn {
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
