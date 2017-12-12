//
// Created by Dani Postigo on 11/21/16.
//

import Foundation
import UIKit

extension UITabBarItem {
    public convenience init(title: String) {
        self.init(title: title, image: UIImage(), selectedImage: UIImage())
    }
}

extension UITabBarController {
    public convenience init(viewControllers: [UIViewController]) {
        self.init(); self.viewControllers = viewControllers
    }
}