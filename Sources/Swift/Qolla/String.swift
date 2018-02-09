//
// Created by Daniela Postigo on 1/23/18.
//

import Foundation

extension String {
	public var newLine: String {
		return self + "\n"
	}
	
	public var tabbed: String {
		return self.tabbed(1)
	}
	
	public func tabbed( _ count: Int) -> String {
		let components = self.components(separatedBy: "\n")
		let tab = Array(repeating: "\t", count: count).joined()
		return components.map { tab + $0 }.joined(separator: "\n")
	}
}