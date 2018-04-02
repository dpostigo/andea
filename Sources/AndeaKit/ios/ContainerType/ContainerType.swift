//
// Created by Daniela Postigo on 4/1/18.
// Copyright (c) 2018 Daniela postigo. All rights reserved.
//

import Foundation

public protocol ContainerType: class {
    associatedtype ChildType: UIViewController
    
    var contentViewController: ChildType? { get }
    func addContentViewController(_ newValue: UIViewController?)
    func removeContentViewController(_ oldValue: UIViewController?)
}

extension ContainerType where ChildType == UINavigationController {
    //    public var rootViewController: UIViewController? { return self.contentViewController?.rootViewController }
    public var topViewController: UIViewController? {
        return self.contentViewController?.topViewController
    }
}


extension ContainerType where Self: UIViewController {
    public func addContentViewController(_ newValue: UIViewController?) {
        newValue.some {
            // $0.view.frame = self.view.bounds
            self.view.embed($0.view, from: self.view.safeAreaLayoutGuide)
            $0.didMove(toParentViewController: self)
        }
    }
    
    public func removeContentViewController(_ oldValue: UIViewController?) {
        oldValue.some {
            $0.willMove(toParentViewController: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParentViewController()
        }
    }
}



