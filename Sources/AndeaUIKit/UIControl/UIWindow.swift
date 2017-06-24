//
// Created by Dani Postigo on 11/24/16.
//

import Foundation
import UIKit

extension UIWindow {
    public convenience init(frame: CGRect, windowLevel: UIWindowLevel) {
        self.init(frame: frame); self.windowLevel = UIWindowLevelNormal
    }

    public convenience init(frame: CGRect, windowLevel: UIWindowLevel, backgroundColor: UIColor) {
        self.init(frame: frame, windowLevel: windowLevel); self.backgroundColor = UIColor.red
    }
}
