//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation
import UIKit

public protocol UIBarButtonItemRepresentable: Autorepresentable {
    var barButtonItem: UIBarButtonItem { get }
    static var barButtonItems: [UIBarButtonItem] { get }
}

extension UIBarButtonItemRepresentable {
    public static var barButtonItems: [UIBarButtonItem] {
        return self.all.barButtonItems
    }
}

extension Sequence where Element: UIBarButtonItemRepresentable {
    public var barButtonItems: [UIBarButtonItem] { return self.map { $0.barButtonItem } }
}

extension UIBarButtonItemRepresentable where Self: Titled {
    public var barButtonItem: UIBarButtonItem {
        return UIBarButtonItem(title: self.title)
    }
    
}

extension UIBarButtonItem {
    
    public convenience init<T: Titled>(title titled: T, actionHandler: @escaping () -> Void) {
        self.init(title: titled.title) { _ in actionHandler() }
    }
    
    public convenience init<T: Titled>(title titled: T, actionHandler: @escaping (T) -> Void) {
        self.init(title: titled.title) { _ in actionHandler(titled) }
    }
    
    public convenience init<T: Titled>(title titled: T, actionHandler: @escaping (T, UIBarButtonItem) -> Void) {
        self.init(title: titled.title) { actionHandler(titled, $0) }
    }
}

extension Autorepresentable where Self: Titled {
    public func barButtonItem(actionHandler: @escaping (Self) -> Void) -> UIBarButtonItem {
        return UIBarButtonItem(title: self, actionHandler: actionHandler)
    }
    
    public static func barButtonItems(actionHandler: @escaping (Self) -> Void) -> [UIBarButtonItem] {
        return self.all.barButtonItems(actionHandler: actionHandler)
    }
}

extension Sequence where Element: Titled {
    
    public func barButtonItems(_ actionHandler: @escaping (Element) -> Void) -> [UIBarButtonItem] {
        return self.barButtonItems(actionHandler: actionHandler)
    }
    public func barButtonItems(actionHandler: @escaping (Element) -> Void) -> [UIBarButtonItem] {
        return self.map { UIBarButtonItem(title: $0, actionHandler: actionHandler) }
    }
}
