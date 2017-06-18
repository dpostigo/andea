//
// Created by Dani Postigo on 9/30/16.
//

import Foundation
import UIKit

extension UIBarButtonItem {

    public convenience init(target: AnyObject?, action: Selector) {
        self.init(); self.target = self; self.action = action
    }

    public convenience init(image: UIImage?, target: AnyObject? = nil, action: Selector? = nil) {
        self.init(image: image, style: .plain, target: target, action: action ?? nil)
    }

    public convenience init(title: String?, target: AnyObject? = nil, action: Selector? = nil) {
        self.init(title: title, style: .plain, target: target, action: action ?? nil)
    }

    public convenience init(customView: UIView, target: AnyObject?, action: Selector) {
        self.init(customView: customView); self.target = self; self.action = action
    }
}
