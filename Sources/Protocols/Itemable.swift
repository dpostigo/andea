//
// Created by Daniela Postigo on 12/14/17.
//

import Foundation


public protocol Itemable: class {
	associatedtype Section: Equatable
	associatedtype Row

	var content: [(section: Section, rows: [Row])] { get set }
}


//extension Itemable where Row: Equatable {
//
//    public func indexPath(of: Row) -> IndexPath {
//
//    }
//}



extension Itemable {
	public typealias Item = (section: Self.Section, rows: [Self.Row])

	public subscript (section: Section) -> [Row]? {
		get { return self.item(at: section)?.rows }
		set {
			guard var item = self.item(at: section), let newValue = newValue else { return }
			item.rows = newValue
			self.content[self.index(of: section)] = item
		}
	}

	public func set(_ row: Row, at indexPath: IndexPath) {
		guard var item = self.item(at: indexPath) else { return }
		item.rows[indexPath.row] = row
		self.set(item.rows, for: item.section)
	}
	public func set(_ rows: [Row], for section: Section) {
		if self.item(at: section) == nil {
			self.content.append((section: section, rows: rows) )
			return
		}
		var item: Item = self.item(at: section)!
		item.rows = rows
		let index = self.index(of: section)
		self.content[index] = item
	}


	public func row(at indexPath: IndexPath) -> Row {
		return self.content[indexPath.section].rows[indexPath.row]
	}

	public func rows(at index: Int) -> [Row] {
		return self.content[index].rows
	}

	public func rows(for section: Section) -> [Row]? {
		return self.content.select(({ $0.section == section }))?.rows
	}

	public func section(at indexPath: IndexPath) -> Section {
		return self.content[indexPath.section].section
	}

	public func section(at index: Int) -> Section {
		return self.content[index].section
	}

	public func item(at indexPath: IndexPath) -> (section: Section, rows: [Row])? {
		return self.content[indexPath.section]
	}
	public func item(at index: Int) -> (section: Section, rows: [Row])? {
		return self.content[index]
	}
	public func item(at section: Section) -> (section: Section, rows: [Row])? {
		return self.content.select({ $0.section == section })
	}

	public func index(of section: Section) -> Int {
		return self.content.index(where: { $0.section == section })!
	}

	@discardableResult public func remove(_ section: Section) -> Item {
		let index = self.index(of: section)
		return self.content.remove(at: index)
	}

	public func append(_ row: Row, in section: Section) {
		self.append(row, at: self.index(of: section))
	}

	func append(_ row: Row, at index: Int) {
		var rows = self.rows(at: index)
		rows.append(row)
		self.content[index] = (section: self.section(at: index), rows: rows)
	}

	// MARK:

	public func numberOfSections() -> Int {
		return self.content.count
	}

	public func numberOfRows(in section: Section) -> Int {
		return self.content[self.index(of: section)].rows.count
	}

	public func numberOfRows(at section: Int) -> Int {
		return self.content[section].rows.count
	}


}



extension Array where Iterator.Element == (section: Any, rows: Array<Any>) {

	public subscript (row indexPath: IndexPath) -> Any {
		get {
			let element = self[indexPath.section]
			return element.rows[indexPath.row]
		}
		set {
			var element = self[indexPath.section]
			element.rows[indexPath.row] = newValue
			self[indexPath.section] = element
		}
	}

}
