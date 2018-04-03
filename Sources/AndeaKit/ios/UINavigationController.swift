//
// Created by Dani Postigo on 11/18/16.
//

import Foundation
import UIKit

extension UINavigationController {
    public convenience init(rootViewController: UIViewController, navigationBarClass: AnyClass?) {
        self.init(navigationBarClass: navigationBarClass, toolbarClass: nil)
        self.setViewControllers([rootViewController], animated: false)
    }

   
    public convenience init(rootViewController: UIViewController, navigationBarHidden: Bool = false, backgroundColor: UIColor? = nil) {
        self.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = navigationBarHidden
        backgroundColor.some { self.view.backgroundColor = $0 }
        // self.view.backgroundColor = backgroundColor
    }
    
    public var rootViewController: UIViewController? {
        return self.viewControllers.first
    }
    
    public func rootViewController<T: UIViewController>(_ viewControllerClass: T.Type = T.self) -> T? {
        return self.rootViewController as? T
    }

}
