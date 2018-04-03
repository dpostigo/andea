//
// Created by Daniela Postigo on 3/24/18.
//

import Foundation

public protocol UIViewControllerAppProtocol:  UIBarButtonItemRepresentable, Titled {
    var viewController: UIViewController { get }
    static var root: Self { get }
}

extension UIViewControllerAppProtocol {
    
    public static var root: Self {
        return self.init(rawValue: 0)!
    }
    
    public static var rootViewController: UIViewController {
        return self.root.viewController
    }
    
    // MARK: Instance
    
    public func navigationController(backgroundColor: UIColor? = nil) -> UINavigationController {
        return UINavigationController(rootViewController: self.viewController, backgroundColor: backgroundColor)
    }
}


extension UINavigationController {
    
    public convenience init<T: UIViewControllerAppProtocol>(rootViewController root: T, backgroundColor: UIColor? = nil) {
        self.init(rootViewController: root.viewController, backgroundColor: backgroundColor)
    }
}

extension UIViewController {
    public func present(inNavigationController vc: UIViewController, animated: Bool, completion: Completion? = nil) {
        self.present(UINavigationController(rootViewController: vc), animated: animated, completion: completion)
    }
}

