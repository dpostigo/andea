//
// Created by Daniela Postigo on 7/19/17.
//

import Cocoa

extension NSButton {
    public convenience init(bezelStyle: NSButton.BezelStyle) {
        self.init(); self.bezelStyle = bezelStyle
    }

    public convenience init(image: NSImage) {
        self.init(image: image, target: nil, action: nil)
    }

    public convenience init(title: String) {
        self.init(title: title, target: nil, action: nil)
    }

    public func toggleState(_ sender: Any? = nil) {
        self.state = self.state == NSControl.StateValue.on ? NSControl.StateValue.off : NSControl.StateValue.on
    }
}


extension NSControl {

    public func add(target: AnyObject?, for action: Selector? = nil) {
        self.add(target, forAction: action)
    }

    public func add(_ target: AnyObject?, forAction action: Selector? = nil) {
        self.target = target
        self.action = action
    }
}
