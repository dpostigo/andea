//
// Created by Daniela Postigo on 3/12/18.
//

import Foundation

extension UIControl {
    public convenience init(_ target: Any?, action: Selector, for events: UIControlEvents) {
        self.init(); self.addTarget(target, action: action, for: events)
    }
}

