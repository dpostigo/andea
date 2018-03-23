//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

extension BezierPath {
    public convenience init(circleWithRadius radius: CGFloat) {
        self.init(ovalIn: CGRect(width: radius, height: radius))
    }
    
    public convenience init(start: CGPoint?) {
        self.init(); start.some { self.move(to: $0) }
    }
    
    public func addLines(to points: [CGPoint]) {
        points.forEach { self.addLine(to: $0) }
    }
    public func close(at point: CGPoint?) {
        point.some { self.move(to: $0) }; self.close()
    }
    
    
}

#if os(macOS)
    
import AppKit

extension NSBezierPath {
    func addLine(to: NSPoint) {
        self.line(to: to)
    }
}
    
#endif

