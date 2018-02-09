//
// Created by Daniela Postigo on 1/13/18.
//

import Foundation

extension URL {
	public static func +(lhs: URL, rhs: String) -> URL {
		return lhs.appendingPathComponent(rhs)
	}
	
	public static func +=(lhs: inout URL, rhs: String) {
		lhs.appendPathComponent(rhs)
	}
}
