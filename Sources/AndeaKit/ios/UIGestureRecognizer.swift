//
// Created by Daniela Postigo on 12/23/17.
//

import Foundation
import UIKit

extension UIGestureRecognizerState: CustomDebugStringConvertible {
    public static var all: [UIGestureRecognizerState] {
        return UIGestureRecognizerState.failed.rawValue.times.flatMap { UIGestureRecognizerState(rawValue: $0) }
    }
    
    public var debugDescription: String {
        return self.descriptionValue.stringValue
    }
    
    enum description: Int, Autorepresentable {
        case possible
        case began
        case changed
        case ended
        case cancelled
        case failed
    }
    
    var descriptionValue: description {
        switch self {
            case .began: return .began
            case .possible: return .possible
            case .changed: return .changed
            case .ended: return .ended
            case .cancelled: return .cancelled
            case .failed: return .failed
        }
    }
}