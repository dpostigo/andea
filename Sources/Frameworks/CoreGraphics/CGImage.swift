//
// Created by Daniela Postigo on 3/24/18.
//

import Foundation

extension CGImage {
    var isOpaque: Bool {
        return !self.hasAlphaComponent
    }
    
    var hasAlphaComponent: Bool {
        return (
            self.alphaInfo == .first ||
            self.alphaInfo == .last ||
            self.alphaInfo == .premultipliedFirst ||
            self.alphaInfo == .premultipliedLast
        )
    }
}

#if os(iOS)
extension CGImage {
    public var image: UIImage {
        return UIImage(cgImage: self)
    }
}
#endif