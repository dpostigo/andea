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
}
