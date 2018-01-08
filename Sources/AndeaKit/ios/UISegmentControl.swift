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

	open var titles: [String] {
		get { return self.numberOfSegments.times.flatMap({ self.titleForSegment(at: $0) }) }
		set {
			self.removeAllSegments()
			newValue.reversed().forEach({ self.insertSegment(withTitle: $0, at: 0, animated: false)  })
		}
	}

	open var titleTextSizes: [CGSize]? {
		guard let attributes = self.titleTextAttributes(for: .normal) as? [NSAttributedStringKey: Any] else { return nil }
		return self.titles.map({ $0.size(withAttributes: attributes) })
	}


	open var segmentSize: CGSize {
		return [self.bounds.size.width / self.numberOfSegments, self.height]
	}

	open var segmentLayoutFrames: [CGRect] {
		let size: CGSize = self.segmentSize
		return self.numberOfSegments.times.map({ .init(origin: [size.width * $0, 0], size: size) })
	}
}
