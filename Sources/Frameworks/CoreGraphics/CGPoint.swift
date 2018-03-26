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
    
    public init(size: CGSize) {
        self.init(x: size.width, y: size.height)
    }
}

