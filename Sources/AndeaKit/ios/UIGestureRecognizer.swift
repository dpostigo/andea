//
// Created by Daniela Postigo on 12/23/17.
//

import Foundation
import UIKit

public enum UIGestureRecognizerKind: Int, Autorepresentable {
	case tap
	case pinch
	case rotation
	case swipe
	case pan
	case screenEdge
	case longPress
}