//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

extension SessionManager {
    open func cancelAllTasks() { self.session.cancelAllTasks() }
}

extension URLSession {
    public func cancelAllTasks() {
        self.getAllTasks { $0.forEach { $0.cancel() } }
    }
}
