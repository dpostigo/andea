//
// Created by Dani Postigo on 10/3/16.
//

import Foundation
import UIKit

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else {
            return nil
        }
        self.init(cgImage: cgImage)
    }


    public var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }

    public static func blank(size: CGSize = .zero) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let graphicsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = graphicsImage?.cgImage else { return nil }
        return self.init(cgImage: image)
    }

    public convenience init?(named: String, in bundle: Bundle) {
        self.init(named: named, in: bundle, compatibleWith: nil)
    }
}

public func UIGraphicsImageContext(_ size: CGSize, handler: () -> Void) -> UIImage? {
    UIGraphicsBeginImageContext(size)
    handler()
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    guard let cgImage = image?.cgImage else { return nil }
    return UIImage(cgImage: cgImage)
}

