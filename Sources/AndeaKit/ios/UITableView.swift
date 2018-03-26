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


public enum UITableViewBackgroundState: ParameterRepresentable {
	case none
	case loading(Bool)
	case loaded([Any]?, UIView)
	
	public var rawValue: Int {
		switch self {
			case .none: return 0
			case .loading: return 1
			case .loaded: return 2
		}
	}
}

extension UITableView {
	
	public func setBackgroundViewState(_ newValue: UITableViewBackgroundState?) {
		newValue.some { self.backgroundView = self.backgroundView($0)}
	}
	private func backgroundView(_ backgroundState: UITableViewBackgroundState) -> UIView? {
		switch backgroundState {
			case .none: return nil
			case .loaded(let items, let view): return (items ?? []).isEmpty ? view : nil
			case .loading(let animating): return UIActivityIndicatorView(frame: self.bounds, isAnimating: animating)
		}
	}
}

extension UITableView {

	public var activityBackgroundView: UIActivityIndicatorView {
		return UIActivityIndicatorView(frame: self.bounds, isAnimating: true)
	}

	public func beginRefreshing(animated: Bool = false) {
		guard let control = self.refreshControl else { return }
		guard !control.isRefreshing else { return }
		if animated {
			self.setContentOffset([0, self.contentOffset.y - control.height], animated: animated)
		} else {
			self.contentOffset.y = self.contentOffset.y - control.height
		}
		control.beginRefreshing()
		control.sendActions(for: .valueChanged)
	}

	
	// MARK: Cells
	
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

	open func dequeueReusableCell<Cell: UITableViewCell>(_ cellClass: Cell.Type = Cell.self, at indexPath: IndexPath) -> Cell {
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
	
	// MARK: Single
	
	public func deleteRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.deleteRows(at: [indexPath], with: animation, completion: completion)
	}

	public func insertRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.insertRows(at: [indexPath], with: animation, completion: completion)
	}
	
	public func reloadRow(at indexPath: IndexPath, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.reloadRows(at: [indexPath], with: animation, completion: completion)
	}
	
	// MARK: Index
	
	public func insertRow(at index: Int, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.insertRow(at: [0, index], with: animation, completion: completion)
	}
	
	public func reloadRow(at index: Int, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.reloadRow(at: [0, index], with: animation, completion: completion)
	}
	
	public func deleteRow(at index: Int, with animation: UITableViewRowAnimation, completion: Completion? = nil) {
		self.deleteRow(at: [0, index], with: animation, completion: completion)
	}

}
