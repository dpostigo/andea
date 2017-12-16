//
// Created by Daniela Postigo on 7/22/17.
//

import Foundation

extension IndexPath {
    public func next() -> IndexPath {
        return IndexPath(row: self.row + 1, section: self.section)
    }
}


extension IndexSet {
    public var arrayRepresentation: [Int] {
        get {  return Array(self) }
        set {
            self.removeAll()
            newValue.forEach({ self.insert($0) })
        }
    }
}

extension NSIndexSet {
    @objc open var arrayRepresentation: NSArray {
        return NSArray(array: self.integerRepresentation)
    }

    @objc open var integerRepresentation: [Int] {
        return (self as IndexSet).arrayRepresentation
    }
}
