//
//  ADTableViewDatasource.swift
//  Alamofire
//
//  Created by Daniela Postigo on 8/6/17.
//

#if os(OSX)
import Foundation

public enum ADTableColumn: Int, Autorepresentable { case column }

public protocol ADTableViewDatasource {
    associatedtype Columns: RawRepresentable = ADTableColumn
    var identifiers: [NSUserInterfaceItemIdentifier] { get }
}


extension ADTableViewDatasource {
    public var columns: [NSTableColumn] {
        return self.identifiers.map({ NSTableColumn(identifier: $0) })
    }
}

extension ADTableViewDatasource where Self.Columns: Autorepresentable {
    public var identifiers: [NSUserInterfaceItemIdentifier] { return Columns.itemIdentifiers }
}

#endif
