//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import AppKit

open class ADTableViewController: NSViewController {
    open lazy var tableView: NSTableView = ({ return type(of: self).createTableView() })()

    // MARK: View lifecycle

    override open func loadView() {
        self.view = NSView(frame: NSWindow.systemLayoutRect)
        self.view.wantsLayer = NSApplication.wantsLayer
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.frame = self.view.bounds
        self.tableView.wantsLayer = self.view.wantsLayer
        self.tableView.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle

        let scrollView = NSScrollView(frame: self.view.bounds)
        self.add(scrollView: scrollView)
        scrollView.contentView.wantsLayer = scrollView.wantsLayer
        scrollView.documentView?.wantsLayer =  scrollView.wantsLayer
    }

    open func add(scrollView: NSScrollView) {
        self.view.embed(scrollView)
        scrollView.contentView.documentView = self.tableView
    }


    class func createTableView() -> NSTableView {
        return NSTableView()
    }

    // MARK: Getters

    open var table: NSTableView { return self.tableView }
    open var scrollView: NSScrollView? { return self.tableView.enclosingScrollView }
}


open class ADOutlineViewController: ADTableViewController {
    override class func createTableView() -> NSTableView {
        return NSOutlineView()
    }

    open var outline: NSOutlineView { return self.tableView as! NSOutlineView }

}
