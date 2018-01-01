//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation

extension CGSize {
	public init(value: CGFloat) {
		self.init(width: value, height: value)
	}

	public func scaledBy(_ valueX: CGFloat, _ valueY: CGFloat) -> CGSize {
		return self.applying(CGAffineTransform(scaleX: valueX, y: valueY))
	}
}

extension CGSize: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = CGFloat

	public init(arrayLiteral elements: ArrayLiteralElement...) {
		self.init(width: elements.first!, height: elements.last!)
	}
}


extension CGRect: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = CGFloat

	public init(arrayLiteral elements: ArrayLiteralElement...) {
		self.init(x: elements[0], y: elements[1], width: elements[2], height: elements[3])
	}
}

