//
// Created by Daniela Postigo on 4/1/18.
// Copyright (c) 2018 Daniela postigo. All rights reserved.
//

import Foundation

open class ContentNavigationController<R: UIViewController>: ContentViewController<UINavigationController> {
    public typealias RootType = R
    
    open var rootViewController: RootType? {
        get { return self.contentViewController?.rootViewController as? RootType }
        set { self.update(newValue) }
    }
    
    open var topViewController: RootType? { return self.contentViewController?.topViewController as? RootType }
    
    // MARK: Init
    
    public init(rootViewController: RootType? = nil) {
        super.init(contentViewController: nil)
        ({ self.rootViewController = rootViewController })()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: Private
    
    private func update(_ root: RootType?) {
        switch root {
            case .none: break
            case .some(let root):
                self.contentViewController = UINavigationController(rootViewController: root)
        }
    }
    
}

