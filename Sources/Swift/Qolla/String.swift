//
// Created by Daniela Postigo on 1/23/18.
//

import Foundation

extension Int {
	public var tabs: String { return String.horizontalTab * self }
	public var newLines: String { return String.newLine * self }
}


extension String {
	
	public static let newLine: String = "\u{000A}"
	public static let carriageReturn: String = "\u{000D}"
	public static let horizontalTab: String = "\t"
	
	// MARK: New line
 
	public var newLine: String {
		return self + String.newLine
	}
	
	public var tabbed: String {
		return self.tabbed(1)
	}
	
	public func tabbed( _ count: Int) -> String {
		let components = self.components(separatedBy: "\n")
		let tab = Array(repeating: "\t", count: count).joined()
		return components.map { tab + $0 }.joined(separator: "\n")
	}
	
	// MARK: Operators
	
	public static func *(lhs: String, rhs: Int) -> String {
		return Array(repeating: lhs, count: rhs).joined()
	}
	
	public static func /(lhs: String, rhs: String) -> [String] {
		return lhs.components(separatedBy: rhs)
	}
}