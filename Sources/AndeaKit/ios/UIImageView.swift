//
// Created by Dani Postigo on 11/18/16.
//

import Foundation
import UIKit

extension UIImageView {
    public convenience init(backgroundColor: UIColor) {
        self.init(); self.backgroundColor = backgroundColor; self.isOpaque = false
    }
    
    public convenience init(image: UIImage?, contentMode: UIViewContentMode = .scaleToFill, cornerRadius: CGFloat = 0) {
        self.init(image: image)
        self.contentMode = contentMode
        self.cornerRadius = cornerRadius

	    guard cornerRadius > 0 else { return }
	    self.clipsToBounds = true
    }
    
    convenience init(image: UIImage, renderingColor: UIColor) {
        self.init(image: image.withRenderingMode(.alwaysTemplate)); self.tintColor = renderingColor
    }
}
