//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

#if os(iOS)

extension CAShapeLayer {

    public var bezierPath: UIBezierPath? {
        get { return self.path?.bezierPath }
        set { self.path = newValue?.cgPath }
    }
    
    public var reverseBezierPath: UIBezierPath? {
        get { return nil }
        set {
            newValue.some {
                self.fillRule = kCAFillRuleEvenOdd
                self.bezierPath = UIBezierPath(path: $0, rect: self.bounds)
            }
        }
    }
    
}


#elseif os(macOS)

#endif

