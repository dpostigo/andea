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
    public convenience init(
        type: UIButtonType = .system,
        title: String,
        font: UIFont? = nil,
        color: UIColor? = nil,
        isUserInteractionEnabled: Bool = true
    ) {
        self.init(type: type)
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.titleLabel?.font = font
        self.isUserInteractionEnabled = isUserInteractionEnabled
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
    
    public convenience init(type: UIButtonType = .custom, image: UIImage?, selectedImage: UIImage? = nil, contentEdgeInsets: UIEdgeInsets = .zero, isUserInteractionEnabled: Bool = true) {
        self.init(type: .custom)
        self.setImage(image, for: .normal)
        self.setImage(selectedImage, for: .selected)
        self.contentEdgeInsets = contentEdgeInsets
	    self.isUserInteractionEnabled = isUserInteractionEnabled
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
    
    public var attributes: [NSAttributedStringKey: Any]? {
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
    
    public func replaceAttribute(_ attribute: NSAttributedStringKey, value: AnyObject?) {
        guard let string = self.currentMutableAttributedTitle else { return }
        string.replaceAttribute(attribute, value: value)
        self.attributedTitle = string
    }
    
    func attributesForState(_ state: UIControlState) -> [NSAttributedStringKey: Any]? {
        guard let string = self.attributedTitle(for: state) else { return nil }
        return string.attributes(at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, string.length))
    }
    
    fileprivate var currentMutableAttributedTitle: NSMutableAttributedString? {
        return self.currentAttributedTitle?.mutableCopy() as? NSMutableAttributedString
    }
}


extension UIPageControl {
    public convenience init(numberOfPages: Int) {
        self.init(); self.numberOfPages = numberOfPages
    }
}
