//
// Created by Dani Postigo on 11/24/16.
//

import Foundation
import UIKit

extension UIDevice {
    @nonobjc public static let isSimulator: Bool = {
        var isSim = false
#if arch(i386) || arch(x86_64)
        isSim = true
#endif
        return isSim
    }()
}