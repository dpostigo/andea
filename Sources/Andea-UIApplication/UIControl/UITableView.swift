//
// Created by Dani Postigo on 9/27/16.
//

import Foundation
import UIKit



extension UITableViewCell {
	open class Subtitle: UITableViewCell {

		public required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		override public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
			super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
		}
	}
}