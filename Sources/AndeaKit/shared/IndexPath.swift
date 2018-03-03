//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation
#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
	
#endif

extension IndexPath {
	public func next() -> IndexPath {
		return [self.section, self.item + 1]
		// return IndexPath(row: self.row + 1, section: self.section)
	}


	
	public static var zero: IndexPath = [0, 0]
}
