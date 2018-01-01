//
// Created by Daniela Postigo on 12/22/17.
//

import Foundation
import UIKit

extension UISegmentedControl {

	public convenience init(items: [Any]?, selectedIndex: Int) {
		self.init(items: items)
		self.selectedSegmentIndex = selectedIndex
	}

	public var titles: [String] {
		get { return (0 ..< self.numberOfSegments).flatMap({ self.titleForSegment(at: $0) }) }
		set {
			self.removeAllSegments()
			newValue.reversed().forEach({ self.insertSegment(withTitle: $0, at: 0, animated: false)  })
		}
	}
}
