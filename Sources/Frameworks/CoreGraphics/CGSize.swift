//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation

extension CGSize: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = CGFloat
	
	public init(arrayLiteral elements: ArrayLiteralElement...) {
		self.init(width: elements.first!, height: elements.last!)
	}
	
	// MARK: Operators
	
	public static func *=(lhs: inout CGSize, right: CGFloat) { lhs = lhs * right }
	
	public static func -(lhs: CGSize, rhs: CGSize) -> CGSize { return [lhs.width - rhs.width, lhs.height - rhs.height] }
	public static func +(lhs: CGSize, rhs: CGSize) -> CGSize { return [lhs.width + rhs.width, lhs.height + rhs.height] }
	
	public static func +(lhs: CGSize, rhs: CGFloat) -> CGSize { return [lhs.width + rhs, lhs.height + rhs] }
	public static func -(lhs: CGSize, rhs: CGFloat) -> CGSize { return [lhs.width - rhs, lhs.height - rhs] }
	public static func *(lhs: CGSize, rhs: CGFloat) -> CGSize { return [lhs.width * rhs, lhs.height * rhs] }
	public static func /(lhs: CGSize, rhs: CGFloat) -> CGSize { return [lhs.width / rhs, lhs.height / rhs] }
	
	public static func +(lhs: CGSize, rhs: Double) -> CGSize { return [lhs.width + CGFloat(rhs), lhs.height + CGFloat(rhs)] }
	public static func -(lhs: CGSize, rhs: Double) -> CGSize { return [lhs.width - CGFloat(rhs), lhs.height - CGFloat(rhs)] }
	public static func *(lhs: CGSize, rhs: Double) -> CGSize { return [lhs.width * CGFloat(rhs), lhs.height * CGFloat(rhs)] }
	public static func /(lhs: CGSize, rhs: Double) -> CGSize { return [lhs.width / CGFloat(rhs), lhs.height / CGFloat(rhs)] }
	
	// MARK: Getters
	
	public var rect: CGRect { return CGRect(origin: .zero, size: self) }
	public var ratio: CGFloat { return self.width / self.height }
}


extension CGSize {
	
	
	// MARK: Methods
	
	public func scaledBy(_ valueX: CGFloat, _ valueY: CGFloat) -> CGSize {
		return self.applying(CGAffineTransform(scaleX: valueX, y: valueY))
	}

	public func ratio(to: CGSize) -> CGFloat {
		return self.ratio > to.ratio ? to.width / self.width : to.height / self.height
	}
	
	
	// MARK: Convenience initializers
	
	public init(value: CGFloat) {
		self.init(width: value, height: value)
	}
	
#if os(iOS)
	public static var compressed: CGSize {
		return UILayoutFittingCompressedSize
	}
#endif

}

