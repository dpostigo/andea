//
// Created by Daniela Postigo on 7/14/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import AppKit
import Andea


class AppContentViewController: NSSplitViewController {
    var toolbarView: NSView? { return self.toolbar?.view }
    var toolbar: NSViewController? { return self.splitViewItems.last?.viewController }

    var contentViewController: NSViewController? {
        set { self.set(contentViewController: newValue) }
        get { return self.splitViewItems.first?.viewController }
    }

    // MARK: Init

    override init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)

        self.splitView = ClearSplitView(autolayout: false)

        self.addSplitViewItem(NSSplitViewItem(viewController: NSViewController(view: NSView())))
        self.addSplitViewItem(NSSplitViewItem(viewController: NSViewController(view: NSView())))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.wantsLayer = NSApplication.wantsLayer
        self.splitView.isVertical = false
        self.splitView.dividerStyle = .thin
    }

    // MARK: Private

    private func set(contentViewController vc: NSViewController?) {
        guard let vc = vc else { return }
        self.removeSplitViewItem(at: 0)
        self.insertSplitViewItem(NSSplitViewItem(viewController: vc), at: 0)
    }

    // MARK: NSSplitView

    override func splitView(_ splitView: NSSplitView, shouldHideDividerAt dividerIndex: Int) -> Bool {
        return true
        // return super.splitView(splitView, shouldHideDividerAt: dividerIndex)
    }

    //    override func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
    //        return false
    //        // return super.splitView(splitView, canCollapseSubview: subview)
    //    }
    //    override func splitView(_ splitView: NSSplitView, shouldCollapseSubview subview: NSView, forDoubleClickOnDividerAt dividerIndex: Int) -> Bool {
    //        return false
    //        // return super.splitView(splitView, shouldCollapseSubview: subview, forDoubleClickOnDividerAt: dividerIndex)
    //    }

    override func splitView(_ splitView: NSSplitView, effectiveRect proposedEffectiveRect: NSRect, forDrawnRect drawnRect: NSRect, ofDividerAt dividerIndex: Int) -> NSRect {
        return .zero
        // return super.splitView(splitView, effectiveRect: proposedEffectiveRect, forDrawnRect: drawnRect, ofDividerAt: dividerIndex)
    }

}
