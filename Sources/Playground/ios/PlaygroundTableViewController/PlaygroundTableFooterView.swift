//
// Created by Daniela Postigo on 1/6/18.
//

import Foundation
import UIKit

open class PlaygroundTableFooterView: UIView {
	let stack: UIStackView

	var labels: [UILabel] { return self.stack.subviews.flatMap({ $0 as? UILabel }) }
	// MARK: Init

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override public init(frame: CGRect) {
		self.stack = UIStackView(
			axis: .horizontal,
			distribution: .equalCentering,
			views: 3.times.map({ _ in UILabel(title: "Title") })
		)

		super.init(frame: frame)

		self.backgroundColor = .black
		self.tintColor = .white
		self.embed(stack, from: self.safeAreaLayoutGuide)
	}

	override open func tintColorDidChange() {
		super.tintColorDidChange()

		self.labels.forEach({ $0.textColor = self.tintColor })
	}
}