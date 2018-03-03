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
	
	public func newLine(_ count: Int) -> String {
		return self + count.newLines
	}
	
	// MARK: Tab
	
	
	public var horizontalTab: String {
		return String.horizontalTab + self
	}
	
	
	public func tabbed( _ count: Int) -> String {
		let components = self / String.newLine
		return components.map { count.tabs + $0 }.joined(separator: "\n")
	}
	
	// MARK: Operators
	
	public static func *(lhs: String, rhs: Int) -> String {
		return Array(repeating: lhs, count: rhs).joined()
	}
	
	public static func /(lhs: String, rhs: String) -> [String] {
		return lhs.components(separatedBy: rhs)
	}
	
}

