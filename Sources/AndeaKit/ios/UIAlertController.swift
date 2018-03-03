//
// Created by Daniela Postigo on 1/4/18.
//

import Foundation
import UIKit

extension UIAlertController {
	public convenience init(error: Error) {
		self.init(title: "Error", message: "\(error)", preferredStyle: .alert)
		self.addAction(UIAlertAction(title: "OK", style: .default))
	}
}