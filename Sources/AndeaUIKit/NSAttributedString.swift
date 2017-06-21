//
// Created by Dani Postigo on 12/15/16.
//

import Foundation

//#if os(iOS)
//import UIKit
//#elseif os(OSX)
//import AppKit
//#endif

//#if os(iOS) || os(watchOS) || os(tvOS)
//let color = UIColor.redColor()
//#elseif os(OSX)
//let color = NSColor.redColor()
//#else
//println("OMG, it's that mythical new Apple product!!!")
//#endif
//import UIKit

extension NSMutableAttributedString {
    
    public func replaceAttribute(_ attribute: String, value: Any?) {
        guard var attributes = self.attributes else { return }
        if let value = value { attributes[attribute] = value } else { attributes.removeValue(forKey: attribute) }
        self.attributes = attributes
    }
    
    override public var attributes: [String: Any]? {
        get { return super.attributes }
        set {
            guard self.length > 0, let newValue = newValue else { return }
            self.setAttributes(newValue, range: self.stringRange)
        }
    }
    
}

extension NSAttributedString {
    fileprivate var stringRange: NSRange { return NSMakeRange(0, self.length) }
    
    public var attributes: [String: Any]? {
        guard self.length > 0 else { return nil }
        return self.attributes(at: 0, longestEffectiveRange: nil, in: self.stringRange)
    }
}


