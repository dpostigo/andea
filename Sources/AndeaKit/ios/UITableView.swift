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

	open func register<T: UITableViewCell>(_ cellClass: T.Type = T.self) {
		self.register(cellClass, forCellReuseIdentifier: cellClass.identifier)
	}

	open func register<T: UITableViewHeaderFooterView>(_ cellClass: T.Type = T.self) {
		self.register(cellClass, forHeaderFooterViewReuseIdentifier: cellClass.identifier)
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