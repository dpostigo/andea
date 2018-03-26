//
//  UIViewController.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UIViewController {
    public convenience init(color: UIColor) {
        self.init(); self.view.backgroundColor = color
    }

    public convenience init(viewControllerTitle: String) {
        self.init(); self.title = viewControllerTitle
    }

    public convenience init(viewControllerTitle: String, color: UIColor) {
        self.init(viewControllerTitle: viewControllerTitle); self.view.backgroundColor = color
    }

    public convenience init(tabBarItemTitle title: String) {
        self.init(viewControllerTitle: title)
        self.tabBarItem = UITabBarItem(title: title)
    }

    @objc public func dismiss(_ sender: AnyObject? = nil) {
        self.dismiss(animated: true)
    }

    public func dismiss(animated: Bool) {
        if self.presentingViewController != nil {
            self.dismiss(animated: animated, completion: nil)
        } else if let nav = self.navigationController {
            nav.popViewController(animated: animated)
        }
    }

    
    public func dismiss(completion: @escaping () -> Void) {
        self.dismiss(animated: true, completion: completion)
    }
    
    // MARK:

    public func tabBarItem(_ tabBarItem: UITabBarItem? = nil) -> Self {
        self.tabBarItem = tabBarItem ?? UITabBarItem(title: self.title ?? ""); return self
    }

    public func withTitle(_ title: String) -> Self {
        self.title = title; return self
    }


    public static var stringIdentifier: String {
        return String(describing: self)
    }

    public func addChildViewController(_ vc: UIViewController, inView: UIView) {
        self.addChildViewController(vc)
        inView.addView(vc.view)
    }
    
    public func `in`<T: UIViewController>(_ viewControllerType: T.Type = T.self) -> UIViewController {
        switch viewControllerType {
            case let type as UINavigationController.Type: return type.init(rootViewController: self)
            default: return self
        }
    }
    
    public func childViewController<T: UIViewController>(_ viewControllerClass: T.Type = T.self) -> T? {
        return self.childViewControllers(viewControllerClass).first
    }
    
    public func childViewControllers<T: UIViewController>(_ viewControllerClass: T.Type = T.self) -> [T] {
        return self.childViewControllers.elements()
    }
    
    public func embed(_ vc: UIViewController, from: UILayoutGuide? = nil) {
        let from = from ?? self.view.safeAreaLayoutGuide
        self.addChildViewController(vc)
        self.view.embed(vc.view, from: from)
    }
    
    public func navigationController(_ backgroundColor: UIColor? = nil) -> UINavigationController {
        return UINavigationController(rootViewController: self, backgroundColor: backgroundColor)
    }
}

extension UINavigationController {
    public convenience init(rootViewController: UIViewController, navigationBarHidden: Bool) {
        self.init(rootViewController: rootViewController)
        self.isNavigationBarHidden = navigationBarHidden
    }
}
