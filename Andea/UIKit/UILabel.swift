//
//  UILabel.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UILabel {
    public convenience init(font: UIFont, color: UIColor = UIColor.black) {
        self.init(); self.font = font; self.textColor = color
    }
    
    public convenience init(color: UIColor) {
        self.init(); self.textColor = color
    }
    
    public convenience init(text: String) { self.init(title: text) }
    
    public convenience init(title: String, font: UIFont? = nil, color: UIColor? = nil) {
        self.init()
        self.text = title
        self.font = font
        self.textColor = color
    }
  
    public convenience init(attributedText: NSAttributedString) {
        self.init(); self.attributedText = attributedText
    }
    
    public convenience init(title: String, attributes: [String:AnyObject]) {
        self.init(attributedText: NSAttributedString(string: title, attributes: attributes))
    }
    public convenience init(attributes: [String:AnyObject]) {
        self.init(attributedText: NSAttributedString(string: " ", attributes: attributes))
    }
    
    public func set(attributedString string: String) {
        if let attributedText = self.attributedText {
            self.attributedText = NSAttributedString(string: string, attributes: attributedText.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, attributedText.length)))
        }
    }

    public var attributedString: String? {
        get {
            return self.attributedText?.string
        }
        set {
            if let newValue = newValue {
                self.set(attributedString: newValue)
            }
        }
    }
}
