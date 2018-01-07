//
// Created by Daniela Postigo on 1/6/18.
//

import Foundation
import UIKit

open class PlaygroundTableViewController: UITableViewController {

	override open func viewDidLoad() {
		super.viewDidLoad()

		let header: PlaygroundTableHeaderFooterView = PlaygroundTableHeaderFooterView(frame: self.view.bounds)

		let size = header.systemLayoutSizeFitting(self.view.bounds.size, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
		header.frame.size.height = size.height
		self.table.tableHeaderView = header
	}

}


