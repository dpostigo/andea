//
// Created by Daniela Postigo on 7/17/17.
//

import Foundation
import AppKit

public class Playground: NSView {
    public convenience init() {
        self.init(frame: NSWindow.systemLayoutRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
}

