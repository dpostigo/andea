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
