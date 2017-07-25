//
// Created by Daniela Postigo on 7/22/17.
//

import Foundation

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
