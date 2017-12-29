//
// Created by Daniela Postigo on 12/28/17.
//

import Foundation


extension Array {
	public var random: Iterator.Element {
		return self[Int.random(0, self.count - 1)]
	}
}
