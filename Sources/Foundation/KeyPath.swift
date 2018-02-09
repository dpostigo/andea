//
// Created by Daniela Postigo on 8/7/17.
//

import Foundation

extension AnyKeyPath {
    
    open var rootString: String { return String(describing: type(of: self).rootType) }
    open var kvcString: String? {
        guard let value = self._kvcKeyPathString else { return nil }
        return "\(self.rootString).\(value)"
    }
    
}
