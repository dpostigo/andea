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
		return [self.section, self.row + 1]
		// return IndexPath(row: self.row + 1, section: self.section)
	}


	public static var items: Helper { return Helper.item }
	public static var rows: Helper { return Helper.row }

	public enum Helper {
		case item
		case row

		public var zero: IndexPath {
			switch self {
				case .item: return IndexPath(item: 0, section: 0)
				case .row: return IndexPath(row: 0, section: 0)
			}
		}
	}
}
