//
// Created by Daniela Postigo on 7/1/17.
//

import Foundation
import AppKit

extension NSWindow {
    public static let systemSize: CGSize = CGSize(width: 480, height: 270)
    public static let systemLayoutRect: CGRect = CGRect(size: NSWindow.systemSize)
    public static let systemStyleMask: NSWindowStyleMask = [.titled, .closable, .resizable, .miniaturizable]

    public func addChildWindowController(_ wc: NSWindowController, ordered place: NSWindowOrderingMode) {
        guard let window = wc.window else { return  }
        self.addChildWindow(window, ordered: place)
    }

    public func show(windowController wc: NSWindowController, ordered place: NSWindowOrderingMode) {
        self.addChildWindowController(wc, ordered: place)
        wc.showWindow(nil)
    }
    //    public func show(windowController wc: NSWindowController, ordered place: NSWindowOrderingMode) {
    //        self.addChildWindow(<#T##childWin: NSWindow##AppKit.NSWindow#>, ordered: <#T##NSWindowOrderingMode##AppKit.NSWindowOrderingMode#>)(wc, ordered: place)
    //        wc.showWindow(nil)
    //    }
}

extension NSWindowController {
    public convenience init(contentViewController: NSViewController) {
        self.init(window: NSWindow(contentViewController: contentViewController))
        self.window?.title = contentViewController.title ?? "Untitled"
    }

    public func addChildWindowController(_ wc: NSWindowController, ordered place: NSWindowOrderingMode) {
        self.window?.addChildWindowController(wc, ordered: place)
    }

    public func show(windowController wc: NSWindowController, ordered place: NSWindowOrderingMode) {
        self.window?.show(windowController: wc, ordered: place)
    }

}



extension NSViewController {
    public var sized: NSViewController { return self.sized(NSWindow.systemSize) }

    public func sized(_ size: CGSize) -> Self {
        self.view.frame.size = size; return self
    }
}
