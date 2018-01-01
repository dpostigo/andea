//
// Created by Dani Postigo on 11/18/16.
//

import Foundation
import UIKit

extension UITextField {

    public convenience init(borderStyle: UITextBorderStyle = .none, isUserInteractionEnabled: Bool = true, placeholder: String? = nil) {
        self.init()
        self.borderStyle = borderStyle
        self.isUserInteractionEnabled = isUserInteractionEnabled
        self.placeholder = placeholder
    }

    public func set(leftView: UIView, withMode mode: UITextFieldViewMode) {
        self.leftView = leftView; self.leftViewMode = mode
    }
}
