//
//  NSButton.swift
//  Alamofire
//
//  Created by Daniela Postigo on 8/14/17.
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
        self.state = self.state == NSControl.StateValue.onState ? NSControl.StateValue.offState : NSControl.StateValue.onState
    }
}
