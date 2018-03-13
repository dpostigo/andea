//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

extension SessionManager {
    public func cancelAllTasks() { self.session.cancelAllTasks() }
}

extension URLSession {
    func cancelAllTasks() {
        self.getAllTasks { $0.forEach { $0.cancel() } }
    }
}
