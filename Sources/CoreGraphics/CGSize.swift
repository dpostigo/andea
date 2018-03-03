//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation

extension CGSize {
    #if os(iOS)
	public static var compressed: CGSize {
		return UILayoutFittingCompressedSize
	}
    #endif

	public init(value: CGFloat) {
		self.init(width: value, height: value)
	}

	public func scaledBy(_ valueX: CGFloat, _ valueY: CGFloat) -> CGSize {
		return self.applying(CGAffineTransform(scaleX: valueX, y: valueY))
	}

	public static func *=(lhs: inout CGSize, right: CGFloat) {
		lhs.width *= right
		lhs.height *= right
	}
}


extension CGPoint: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = CGFloat

	public init(arrayLiteral elements: ArrayLiteralElement...) {
		precondition(elements.count == 2)
		self.init(x: elements.first!, y: elements.last!)
	}
}


extension CGSize: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = CGFloat

	public init(arrayLiteral elements: ArrayLiteralElement...) {
		self.init(width: elements.first!, height: elements.last!)
	}
}


