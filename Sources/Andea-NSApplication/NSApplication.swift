//
// Created by Daniela Postigo on 7/14/17.
//

import Foundation
import AppKit

extension NSApplication {
    open static var wantsLayer: Bool {
        return true
    }
}

extension Autorepresentable {
#if os(macOS)
    public static var itemIdentifiers: [NSUserInterfaceItemIdentifier] {
        return self.stringRepresentations.map({ NSUserInterfaceItemIdentifier(rawValue: $0) })
    }
#endif
}


extension AnyKeyPath {

#if os(OSX)
    open var itemIdentifier: NSUserInterfaceItemIdentifier? {
        guard let kvcString = self.kvcString else { return nil }
        return NSUserInterfaceItemIdentifier(rawValue: kvcString)
    }
#endif
}