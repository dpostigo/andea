//
// Created by Dani Postigo on 9/27/16.
//

import Foundation
import UIKit

extension UITableViewCell {
	open class Subtitle: UITableViewCell {

		public required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
			super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		}
	}
}

extension UITableViewController {
	public var table: UITableView { return self.tableView! }
}

extension UITableView {

	open func register(_ views: UIView.Type...) {
		self.register(views.flatMap { $0 as? UITableViewCell.Type })
		self.register(views.flatMap { $0 as? UITableViewHeaderFooterView.Type })
	}

	open func register(_ cells: UITableViewCell.Type...) {
		self.register(cells)
	}
	
	open func register(_ headers: UITableViewHeaderFooterView.Type...) {
		self.register(headers)
	}

	open func register(_ cells: [UITableViewCell.Type]) {
		cells.forEach { self.register($0, forCellReuseIdentifier: $0.identifier) }
	}
	open func register(_ headers: [UITableViewHeaderFooterView.Type]) {
		headers.forEach { self.register($0, forHeaderFooterViewReuseIdentifier: $0.identifier) }
	}

	// MARK: Dequeue

	open func dequeueReusableHeaderFooterView<HeaderFooter: UITableViewHeaderFooterView>(_ viewClass: HeaderFooter.Type = HeaderFooter.self) -> HeaderFooter {
		return self.dequeueReusableHeaderFooterView(withIdentifier: viewClass.identifier) as! HeaderFooter
	}

	open func dequeueReusableCell<Cell: UITableViewCell>(_ cellClass: Cell.Type = Cell.self, _ indexPath: IndexPath) -> Cell {
		return self.dequeueReusableCell(cellClass, for: indexPath)
	}

	open func dequeueReusableCell<Cell: UITableViewCell>(_ cellClass: Cell.Type = Cell.self, for indexPath: IndexPath) -> Cell {
		return self.dequeueReusableCell(withIdentifier: cellClass.identifier, for: indexPath) as! Cell
	}



	// MARK: Reload

	public func reloadSections( _ indexSet: IndexSet, with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.reloadSections(indexSet, with: animation) }, completion: { _ in completion?() })
	}

	public func insertSections( _ indexSet: IndexSet, with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.insertSections(indexSet, with: animation) }, completion: { _ in completion?() })
	}

	public func deleteSections( _ indexSet: IndexSet, with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.deleteSections(indexSet, with: animation) }, completion: { _ in completion?() })
	}

	// MARK: Rows

	public func reloadRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.reloadRows(at: indexPaths, with: animation) }, completion: { _ in completion?() })
	}

	public func insertRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.insertRows(at: indexPaths, with: animation) }, completion: { _ in completion?() })
	}

	public func deleteRows(at indexPaths: [IndexPath], with animation: UITableViewRowAnimation, completion: Completion?) {
		self.performBatchUpdates({ self.deleteRows(at: indexPaths, with: animation) }, completion: { _ in completion?() })
	}
}
