//
//  UIButton.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UIButton {
    public convenience init(title: String) {
        self.init(); self.setTitle(title, for: UIControlState())
    }
    public convenience init(title: String, font: UIFont) {
        self.init(title: title)
        self.titleLabel?.font = font
    }
    
    public convenience init(title: String, font: UIFont, color: UIColor) {
        self.init(title: title, font: font)
        self.setTitleColor(color, for: .normal)
    }
    
    public convenience init(title: String, backgroundColor: UIColor) {
        self.init(title: title); self.backgroundColor = backgroundColor
    }
    
    public convenience init(title: String, font: UIFont, color: UIColor, backgroundColor: UIColor) {
        self.init(title: title, font: font, color: color)
        self.backgroundColor = backgroundColor
    }
    
    public convenience init(title: String, font: UIFont, color: UIColor, contentEdgeInsets: UIEdgeInsets) {
        self.init(title: title, font: font, color: color)
        self.contentEdgeInsets = contentEdgeInsets
    }
    
    public convenience init(title: String, titleColor: UIColor) {
        self.init(title: title); self.setTitleColor(titleColor, for: UIControlState())
    }
    
    public convenience init(attributedTitle: NSAttributedString) {
        self.init()
        self.setAttributedTitle(attributedTitle, for: UIControlState())
    }
    
    public convenience init(image: UIImage?) {
        self.init()
        self.setImage(image, for: UIControlState())
    }
    
    public convenience init(image: UIImage?, selectedImage: UIImage?) {
        self.init(image: image); self.setImage(selectedImage, for: .selected)
    }
    
    public convenience init(image: UIImage?, contentEdgeInsets: UIEdgeInsets) {
        self.init(image: image)
        self.contentEdgeInsets = contentEdgeInsets
    }
    
    public convenience init(userInteractionEnabled: Bool) {
        self.init()
        self.isUserInteractionEnabled = userInteractionEnabled
    }
    
    // MARK:
    
    public convenience init(title: String, color: UIColor) {
        self.init(title: title, titleColor: color)
    }
    
    // MARK: Attributed strings
    
    public var attributes: [String: Any]? {
        set {
            guard let newValue = newValue, let current = self.attributedTitle else { return }
            self.attributedTitle = NSAttributedString(string: current.string, attributes: newValue)
        }
        get { return self.attributesForState(self.state) }
    }
    
    public var attributedTitle: NSAttributedString? {
        get { return self.currentAttributedTitle }
        set { self.setAttributedTitle(newValue, for: self.state) }
    }
    
    public func replaceAttribute(_ attribute: String, value: AnyObject?) {
        guard let string = self.currentMutableAttributedTitle else { return }
        string.replaceAttribute(attribute, value: value)
        self.attributedTitle = string
    }
    
    func attributesForState(_ state: UIControlState) -> [String: Any]? {
        guard let string = self.attributedTitle(for: state) else { return nil }
        return string.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, string.length))
    }
    
    fileprivate var currentMutableAttributedTitle: NSMutableAttributedString? {
        return self.currentAttributedTitle?.mutableCopy() as? NSMutableAttributedString
    }
}
