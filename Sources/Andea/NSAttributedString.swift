//
// Created by Dani Postigo on 12/15/16.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    public func replaceAttribute(_ attribute: NSAttributedStringKey, value: Any?) {
        guard var attributes = self.attributes else { return }
        if let value = value { attributes[attribute] = value } else { attributes.removeValue(forKey: attribute) }
        self.attributes = attributes
    }
    
    override public var attributes: [NSAttributedStringKey: Any]? {
        get { return super.attributes }
        set {
            guard self.length > 0, let newValue = newValue else { return }
            self.setAttributes(newValue, range: self.stringRange)
        }
    }
    
}


extension NSAttributedString {

    public convenience init(string: String, font: UIFont) {
        self.init(string: string, attributes: [.font : font])
    }

    public func appending(_ s: NSAttributedString) -> NSAttributedString {
        let ret = self.mutableCopy() as! NSMutableAttributedString
        ret.append(s); return ret
    }

    public func replacing(_ value: Any, forKey key: NSAttributedStringKey) -> NSAttributedString {
        let ret = self.mutableCopy() as! NSMutableAttributedString
        ret.replaceAttribute(key, value: value)
        return ret
    }

    // MARK: Getters

    fileprivate var stringRange: NSRange { return NSMakeRange(0, self.length) }

    @objc public var attributes: [NSAttributedStringKey: Any]? {
        guard self.length > 0 else { return nil }
        return self.attributes(at: 0, longestEffectiveRange: nil, in: self.stringRange)
    }
}


