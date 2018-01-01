//
// Created by Dani Postigo on 11/27/16.
//

import Foundation

extension FileManager {
    public var documentsDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}


extension URL {
    public var pathExists: Bool {
        return FileManager.default.fileExists(atPath: self.path)
    }
}
