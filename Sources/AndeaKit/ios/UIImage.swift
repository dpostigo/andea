//
// Created by Dani Postigo on 10/3/16.
//

import Foundation
import UIKit

extension UIImage {
    
    // MARK: Init
 
    public convenience init?(color: UIColor, size: CGSize = [1, 1]) {
        let rect = [0, 0, size.width, size.height] as CGRect
        let format = UIGraphicsImageRendererFormat(opaque: false)
        
        let renderer = UIGraphicsImageRenderer(size: rect.size, format: format)
        let image = renderer.image { color.setFill(); $0.fill(rect) }
        guard let cgImage = image.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
  
    // MARK: Methods
    
    public func scaled(to: CGSize) -> UIImage {
        let format = UIGraphicsImageRendererFormat(scale: to.ratio(to: self.size), opaque: false)
        let renderer = UIGraphicsImageRenderer(size: to, format: format)
        return renderer.image { context in
            self.draw(in: [0, 0, to.width, to.height])
        }
    }
    
    // MARK: Getters
    
    public var isOpaque: Bool {
        return self.cgImage?.isOpaque ?? false
    }
    
    public var template: UIImage {
        return self.withRenderingMode(.alwaysTemplate)
    }
    
    // MARK: Static functions
    
    public static func blank(size: CGSize = .zero) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        let graphicsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let image = graphicsImage?.cgImage else { return nil }
        return self.init(cgImage: image)
    }
    
    // MARK: Convenience Init
    
    public convenience init?(named: String, in bundle: Bundle) {
        self.init(named: named, in: bundle, compatibleWith: nil)
    }
    
    public convenience init?(image: UIImage, size to: CGSize) {
        guard let cgImage = image.cgImage else { return nil }
        let scale = to.ratio(to: cgImage.image.size)
        self.init(cgImage: cgImage, scale: scale, orientation: .up)
    }
}


extension UIGraphicsImageRendererFormat {
    public convenience init(scale: CGFloat? = nil, opaque: Bool = false) {
        self.init()
        scale.some { self.scale = $0 }
        self.opaque = opaque
    }
}
