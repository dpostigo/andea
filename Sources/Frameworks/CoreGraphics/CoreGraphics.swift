//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

#if os(iOS)

extension CGPath {
    public var bezierPath: UIBezierPath? { return UIBezierPath(cgPath: self) }
}

#elseif os(macOS)

#endif

extension CGColor {
    public var color: Color? { return Color(cgColor: self) }
}
