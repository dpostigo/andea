//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import AppKit

open class ADTableViewController: NSViewController {
    open var tableView: NSTableView = NSTableView()

    // MARK: View lifecycle

    override open func loadView() {
        self.view = NSView(frame: NSWindow.systemLayoutRect)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.frame = self.view.bounds
        self.tableView.wantsLayer = self.view.wantsLayer
        self.tableView.columnAutoresizingStyle = .lastColumnOnlyAutoresizingStyle

        let scrollView = NSScrollView(frame: self.view.bounds)
        self.add(scrollView: scrollView)
        scrollView.contentView.wantsLayer = scrollView.wantsLayer
        scrollView.documentView?.wantsLayer =  scrollView.wantsLayer
    }

    open func add(scrollView: NSScrollView) {
        self.view.embed(scrollView)
        scrollView.contentView.documentView = self.tableView
    }

}
