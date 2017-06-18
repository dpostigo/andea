//
// Created by Dani Postigo on 10/3/16.
//

import Foundation
import UIKit

extension UIBezierPath {
    public convenience init(circleWithRadius radius: CGFloat) {
        self.init(ovalIn: CGRect(width: radius, height: radius))
    }
}

extension UIBezierPath {

    // MARK: Triangle shape

    public convenience init(triangleInRect rect: CGRect, edge: UIRectEdge) {
        self.init()
        switch edge {
            case UIRectEdge.top:
                self.move(to: CGPoint(x: rect.minX, y: rect.maxY))
                self.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                self.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            case UIRectEdge.bottom:
                self.move(to: CGPoint(x: rect.minX, y: rect.minY))
                self.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
                self.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            case UIRectEdge.left:
                self.move(to: CGPoint(x: rect.maxX, y: rect.minY))
                self.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            case UIRectEdge.right:
                self.move(to: CGPoint(x: rect.minX, y: rect.minY))
                self.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                self.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
                self.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
            default: break
        }
        self.close()
    }

    // MARK: Popover shapes

    public convenience init(popoverInRect rect: CGRect, withSize size: CGSize, edge: UIRectEdge = .bottom, cornerRadius: CGFloat = 0) {
        let rect = edge.offset(popoverRect: rect, forArrowSize: size)
        self.init(roundedRect: rect, cornerRadius: cornerRadius)
        self.append(popoverArrowOfSize: size, forEdge: edge)
    }

    public func append(popoverArrowOfSize size: CGSize, forEdge edge: UIRectEdge = .bottom) {
        let bounds = self.bounds
        var rect = CGRect(size: size)
        switch edge {
            case UIRectEdge.top:    rect.origin = CGPoint(x: bounds.midX - (size.width * 0.5), y: bounds.minY - size.height)
            case UIRectEdge.bottom: rect.origin = CGPoint(x: bounds.midX - (size.width * 0.5), y: bounds.maxY)
            case UIRectEdge.left:   rect.origin = CGPoint(x: bounds.minX - size.width, y: bounds.midY - (size.height * 0.5))
            case UIRectEdge.right:  rect.origin = CGPoint(x: bounds.maxX, y: bounds.midY - (size.height * 0.5))
            default: break
        }
        self.append(UIBezierPath(triangleInRect: rect, edge: edge))
    }

}

extension UIRectEdge {
    fileprivate func offset(popoverRect rect: CGRect, forArrowSize size: CGSize) -> CGRect {
        var rect = rect
        switch self {
            case UIRectEdge.top:    rect = rect.offsetBy(dx: 0, dy: size.height)
            case UIRectEdge.bottom: rect = rect.offsetBy(dx: 0, dy: -size.height)
            case UIRectEdge.left:   rect = rect.offsetBy(dx: size.width, dy: 0)
            case UIRectEdge.right:  rect = rect.offsetBy(dx: -size.width, dy: 0)
            default:break
        }
        return rect
    }
}
