//
// Created by Daniela Postigo on 3/9/18.
//

import Foundation

public protocol TabBarItemRepresentable: Autorepresentable {
    var title: String { get }
    var tabBarItem: UITabBarItem { get }
    var viewController: UIViewController { get }
}

extension TabBarItemRepresentable {
    
    public var title: String { return self.stringValue.capitalized }
    public var image: UIImage? { return nil }
    public var selectedImage: UIImage? { return nil }
    
    public var tabBarItem: UITabBarItem {
        return UITabBarItem(title: self.title, image: self.image, selectedImage: self.selectedImage)
    }
   
    // MARK: Extensions
    
    public var navigationController: UINavigationController {
        let vc = UINavigationController(rootViewController: self.viewController)
        vc.rootViewController!.title = self.title
        vc.tabBarItem = self.tabBarItem
        return vc
    }
    
    public static var viewControllers: [UIViewController] {
        return self.all.map { $0.navigationController }
    }
    
}

extension Sequence where Element: TabBarItemRepresentable {
    public var navigationControllers: [UINavigationController] {
        return self.map { $0.navigationController }
    }
}

extension UITabBarController {
    
    public convenience init<T: TabBarItemRepresentable>(navigationControllers items: [T]) {
        self.init()
        self.viewControllers = items.navigationControllers
    }
    
    public func viewControllers<T: TabBarItemRepresentable>(_ itemType: T.Type = T.self) -> [T: UIViewController] {
        return Dictionary(pairs: itemType.all.flatMap { ($0, self.viewController($0)) as? (T, UIViewController) })
    }
    public func viewController<T: TabBarItemRepresentable>(_ item: T) -> UIViewController? {
        return self.viewControllers.map { $0[item.rawValue] }
                                   .flatMap { $0 as? UINavigationController }
                                   .flatMap { $0.rootViewController }
    }
}
