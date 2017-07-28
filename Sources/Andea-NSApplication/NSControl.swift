//
// Created by Daniela Postigo on 7/19/17.
//

import Cocoa

extension NSControl {

    public func add(target: AnyObject?, for action: Selector? = nil) {
        self.add(target, forAction: action)
    }

    public func add(_ target: AnyObject?, forAction action: Selector? = nil) {
        self.target = target
        self.action = action
    }
}
