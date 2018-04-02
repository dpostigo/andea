//
// Created by Daniela Postigo on 3/12/18.
//

import UIKit
import ActionKit

extension UITableView {
    public var refreshControlHandler: (() -> Void)? {
        get { return nil }
        set {  newValue.some { self.refreshControl = UIRefreshControl(.valueChanged, handler: $0) } }
    }
    
    public var refreshControlEventHandler: ((UIRefreshControl) -> Void)? {
        get { return nil }
        set { newValue.some { self.refreshControl = UIRefreshControl(.valueChanged, actionHandler: $0) } }
    }
}

