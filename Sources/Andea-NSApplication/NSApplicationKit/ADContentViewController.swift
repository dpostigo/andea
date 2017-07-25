//
// Created by Daniela Postigo on 7/14/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import AppKit

open class ADContentViewController: NSSplitViewController {

    open var firstViewController: NSViewController? {
        set { self.setViewController(newValue, at: 0) }
        get { return self.viewController(at: 0) }
    }

    open var firstSplitViewItem: NSSplitViewItem? {
        return self.splitViewItems.first
    }

    open var viewControllers: [NSViewController] {
        return self.splitViewItems.map({ $0.viewController })
    }

    // MARK: Init

    public convenience init(viewControllers vcs: NSViewController...) {
        self.init(viewControllers: vcs)
    }

    required public init(viewControllers: [NSViewController]? = nil) {
        super.init(nibName: nil, bundle: nil)!
        self.splitView = type(of: self).splitView()

        let controllers: [NSViewController] = viewControllers ?? []
        controllers.forEach({ self.addSplitViewItem(NSSplitViewItem(viewController: $0)) })
//        vcs.forEach({ self.addChildViewController($0) })
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    // MARK: View lifecycle

    override open func viewDidLoad() {
        super.viewDidLoad()

        // self.view.wantsLayer = NSApplication.wantsLayer
        // self.splitView.wantsLayer = self.view.wantsLayer

    }

    // MARK: NSSplitView

    open class func splitView() -> NSSplitView {
        let ret = NSSplitView()
        ret.dividerStyle = .thin
        return ret
    }

    open func setViewController(_ vc: NSViewController?, at index: Int) {
        guard let vc = vc else { return }
        self.removeSplitViewItem(at: index)
        self.insertSplitViewItem(NSSplitViewItem(viewController: vc), at: index)
    }

    open func viewController(at index: Int) -> NSViewController? {
        guard index < self.splitViewItems.count else { return nil }
        return self.splitViewItems[index].viewController
    }
//
//    override open func addChildViewController(_ childViewController: NSViewController) {
//        Swift.print("\(type(of: self)).\(#function)")
//        Swift.print("childViewController.frame.size = \(childViewController.view.frame.size.debugDescription)")
//        super.addChildViewController(childViewController)
//    }


}
