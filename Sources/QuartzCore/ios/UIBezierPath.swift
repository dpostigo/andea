//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

extension UIBezierPath {
    
    public convenience init(path: UIBezierPath, rect: CGRect) {
        self.init(rect: rect)
        self.append(path)
        self.usesEvenOddFillRule = true
    }
}

