//
// Created by Dani Postigo on 11/27/16.
//

import Foundation

extension FileManager {
    public var documentsDirectory: URL? {
        return self.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}
