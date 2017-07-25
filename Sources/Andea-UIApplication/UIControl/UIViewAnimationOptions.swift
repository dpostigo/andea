//
// Created by Dani Postigo on 11/27/16.
//

import Foundation
import UIKit

public struct AnimationOptions {
    let duration: TimeInterval
    let delay: TimeInterval
    let options: UIViewAnimationOptions

    public init(duration: TimeInterval = 0.4, delay: TimeInterval = 0, options: UIViewAnimationOptions = UIViewAnimationOptions(rawValue: 0)) {
        self.duration = duration
        self.delay = delay
        self.options = options
    }
}

extension UIView {
    public class func animateWithOptions(_ options: AnimationOptions, animations: @escaping () -> Void, completion: ((Bool) -> Void)? = nil) {
        self.animate(withDuration: options.duration, delay: options.delay, options: options.options, animations: animations, completion: completion)
    }
}
