//
// Created by Daniela Postigo on 7/16/17.
//

import Foundation
import AppKit

open class ADBaseViewController: NSViewController {

    override open func loadView() {
        self.view = NSView(wantsLayer: NSApplication.wantsLayer)
    }

}