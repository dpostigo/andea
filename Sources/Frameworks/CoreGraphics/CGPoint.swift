//
// Created by Daniela Postigo on 3/24/18.
//

import Foundation

extension CGPoint: ExpressibleByArrayLiteral {
    public typealias ArrayLiteralElement = CGFloat
    
    public init(arrayLiteral elements: ArrayLiteralElement...) {
        precondition(elements.count == 2)
        self.init(x: elements.first!, y: elements.last!)
    }
    public var size: CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    
    public func rect(_ size: CGSize) -> CGRect {
        return CGRect(x: self.x, y: self.y, width: size.width, height: size.height)
    }
}

