//
// Created by Dani Postigo on 11/21/16.
//

import Foundation
import UIKit


extension UINavigationBar {
    public func centerTitleVerticalPositionAdjustment(forView titleView: UIView) {
        let adjustment = self.frame.size.height - titleView.frame.size.height
        self.setTitleVerticalPositionAdjustment(adjustment * -0.5, for: .default)
    }
    
    public func center(barButtonItem item: UIBarButtonItem?) {
        guard let item = item else { return }
        let diff = self.frame.size.height - 44
        let adjustment = diff * 0.5
        item.setBackgroundVerticalPositionAdjustment(diff > 0 ? -adjustment : 0, for: .default)
    
    }
}
