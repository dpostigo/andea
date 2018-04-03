//
// Created by Dani Postigo on 9/30/16.
//

import UIKit

extension UIBarButtonItem {

    public convenience init(target: AnyObject?, action: Selector) {
        self.init(); self.target = self; self.action = action
    }

    public convenience init(image: UIImage?, target: Any? = nil, action: Selector? = nil) {
        self.init(image: image, style: .plain, target: target, action: action ?? nil)
    }

    public convenience init(title: String?, target: Any? = nil, action: Selector? = nil) {
        self.init(title: title, style: .plain, target: target, action: action ?? nil)
    }

    public convenience init(customView: UIView, target: AnyObject? = nil, action: Selector? = nil) {
        self.init(customView: customView); self.target = self; self.action = action
    }
    
    
    public convenience init(barButtonSystemItem: UIBarButtonSystemItem) {
        self.init(barButtonSystemItem: barButtonSystemItem, target: nil, action: nil)
    }
}

extension UIBarItem {
    
    public var titleTextAttributes: [NSAttributedStringKey: Any]? {
        get { return self.titleTextAttributes(for: [.normal, .highlighted])?.mapKeys { NSAttributedStringKey($0.key) } }
        set { self.setTitleTextAttributes(newValue, for: [.normal, .highlighted]) }
    }
}

