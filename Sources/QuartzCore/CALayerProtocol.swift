//
// Created by Daniela Postigo on 3/21/18.
//

import QuartzCore

public protocol CALayerProtocol: class {
    var frame: CGRect { get set }
    var isHidden: Bool { get set }
}

extension CALayerProtocol where Self: CALayer {
    public init(frame: CGRect = .zero, isHidden: Bool = false) {
        self.init()
        self.frame = frame
        self.isHidden = isHidden
    }
}


extension CALayer : CALayerProtocol { }


