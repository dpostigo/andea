//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation

extension CGFloat {

	public static var zero: CGFloat { return 0 }
	public static var max: CGFloat { return CGFloat(Int.max) }
}

extension CGFloat {

	public static func /(lhs: CGFloat, rhs: Int) -> CGFloat {
		return lhs / CGFloat(rhs)
	}

	public static func *(lhs: CGFloat, rhs: Int) -> CGFloat {
		return lhs * CGFloat(rhs)
	}
}
