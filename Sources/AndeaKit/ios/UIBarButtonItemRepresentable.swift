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