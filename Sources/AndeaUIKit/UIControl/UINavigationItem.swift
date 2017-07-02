//
// Created by Dani Postigo on 11/21/16.
//

import Foundation
import UIKit

extension UINavigationItem {

    public func center(titleView: UIView, inNavigationBar navigationBar: UINavigationBar?) {
        guard let navigationBar = navigationBar else { return }
        navigationBar.centerTitleVerticalPositionAdjustment(forView: titleView)
    }

    public func set(titleView: UIView, inNavigationBar navigationBar: UINavigationBar?) {
        self.titleView = titleView
        self.center(titleView: titleView, inNavigationBar: navigationBar)
    }

}
