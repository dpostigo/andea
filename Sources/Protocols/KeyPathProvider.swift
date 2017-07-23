//
// Created by Daniela Postigo on 7/22/17.
//

import Foundation

public protocol KeyPathProvider {
    var titleValue: String { get }
    var keyPathValue: String { get }
}

extension NSObject {
    open func dictionaryWithValues<T: KeyPathProvider>(forKeyPaths keyPaths: [T]) -> [String : Any] {
        var ret = [String: Any]()
        keyPaths.forEach({ ret[$0.titleValue] = self.value(forKeyPath: $0.keyPathValue) })
        return ret
    }
}

extension KeyPathProvider where Self: RawRepresentable, Self.RawValue == String {
    public var titleValue: String { return self.rawValue }
}
