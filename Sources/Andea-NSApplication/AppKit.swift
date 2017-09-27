//
// Created by Daniela Postigo on 6/25/17.
//

import Cocoa
import AppKit




extension NSVisualEffectView {
    public convenience init(frame: NSRect, state: NSVisualEffectView.State = .followsWindowActiveState, blendingMode: NSVisualEffectView.BlendingMode) {
        self.init(frame: frame)
        self.state = state
        self.blendingMode = blendingMode
    }


    public convenience init(state: NSVisualEffectView.State) {
        self.init(); self.state = state
    }

    public convenience init(material: NSVisualEffectView.Material, blendingMode: NSVisualEffectView.BlendingMode, state: NSVisualEffectView.State) {
        self.init()
        self.material = material
        self.blendingMode = blendingMode
        self.state = state
    }
}



extension NSToolbar {
    public convenience init(identifier: String, delegate: NSToolbarDelegate) {
        self.init(identifier: NSToolbar.Identifier(rawValue: identifier)); self.delegate = delegate
    }
}


