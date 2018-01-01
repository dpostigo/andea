//
// Created by Daniela Postigo on 7/19/17.
//

import Cocoa

//extension NSControl {
//    public convenience init(wantsLayer flag: Bool) {
////        self.init(wantsLayer: flag)
//         self.init(wants: Layer); self.wantsLayer = flag
//    }
//}

extension NSControl {

    public func add(target: AnyObject?, for action: Selector? = nil) {
        self.add(target, forAction: action)
    }

    public func add(_ target: AnyObject?, forAction action: Selector? = nil) {
        self.target = target
        self.action = action
    }
}


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


extension NSTextField {
	//    public convenience init(wantsLayer flag: Bool) {
	////        super.init(wantsLayer: flag)
	//         self.init(); self.wantsLayer = flag
	//    }

	public convenience init(title: String = "Title", wantsLayer: Bool = NSApplication.wantsLayer){
		self.init()
		self.stringValue = title
		self.wantsLayer = wantsLayer
	}
	public convenience init(title: String = "Title", backgroundColor: NSColor, isBordered: Bool) {
		self.init()
		self.stringValue = title
		self.backgroundColor = backgroundColor
		self.isBordered = isBordered
	}
}
