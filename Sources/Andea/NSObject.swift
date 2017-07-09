//
// Created by Daniela Postigo on 7/8/17.
//

import Foundation

extension Dictionary where Key == NSKeyValueChangeKey {
    public var changeType: NSKeyValueChange? {
        guard let kind = self[NSKeyValueChangeKey.kindKey] as? UInt else { return nil }
        return NSKeyValueChange(rawValue: kind)
    }

    public var newValue: Any? {
        return self[NSKeyValueChangeKey.newKey]
    }
    public var indexSet: IndexSet? {
        return self[NSKeyValueChangeKey.indexesKey] as? IndexSet
    }
}
extension NSKeyValueChange {
    public var stringValue: String {
        switch self {
            case .insertion : return "insertion"
            case .removal : return "removal"
            case .setting : return "setting"
            case .replacement : return "replacement"
        }
    }
}