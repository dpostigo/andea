//
// Created by Daniela Postigo on 3/10/18.
//

import Foundation

extension URLCredentialStorage {
    public func removeAll(for space: URLProtectionSpace) {
        guard let credentials = self.credentials(for: space) else { return }
        credentials.values.forEach { self.remove($0, for: space)}
    }
}

extension URLCredential {
    public convenience init(_ user: String, _ password: String, _ persistence: URLCredential.Persistence) {
        self.init(user: user, password: password, persistence: persistence)
    }
}