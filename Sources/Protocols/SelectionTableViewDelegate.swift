//
// Created by Daniela Postigo on 12/9/17.
//

import Foundation

public protocol SelectionTableViewDelegate {
	func selectionTableViewController(_ viewController: SelectionTableViewController, didSelectRowAt indexPath: IndexPath)
}

public protocol SelectionTableViewController {
	var delegate: SelectionTableViewDelegate? { get set }
	var items: [Any] { get }
	init()
}

extension SelectionTableViewController {
	public init(delegate: SelectionTableViewDelegate) {
		self.init(); self.delegate = delegate
	}

	public func selected(atIndexPath indexPath: IndexPath) {
		self.delegate?.selectionTableViewController(self, didSelectRowAt: indexPath)
	}
}


public protocol Routable {
	static var route: String { get }
}
public protocol HostnameProvider {
	static var hostname: String { get }
}
