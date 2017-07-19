//
// Created by Daniela Postigo on 7/18/17.
//

import Foundation
import AppKit
import Marshal

extension NSObjectController {
    public var contentArray: [Any]? {
        return self.content as? [Any]
    }
}

extension NSTreeController {
}
extension NSArrayController {
    public var indexes: IndexSet {
        return (self.arrangedObjects as! [Any]).indexSet
    }


    public var arrangedArray: [Any]? { return self.arrangedObjects as? [Any] }

    public convenience init(automaticallyRearrangesObjects: Bool, selectsInsertedObjects: Bool = false) {
        self.init(); self.automaticallyRearrangesObjects = automaticallyRearrangesObjects; self.selectsInsertedObjects = selectsInsertedObjects
    }

    public func value(forKeyPath keyPath: String, at index: Int) -> Any? {
        return self.object(at: index)?.value(forKeyPath: keyPath)
    }

    public func object(at index: Int) -> NSObject? {
        return self.value(at: index) as? NSObject
    }

    public func value(at index: Int) -> Any? {
        return (self.arrangedObjects as! [Any])[index]
    }

    public func setSelectedSymmetricDifference(withIndexes indexes: IndexSet? = nil) {
        let selected = indexes ?? self.selectionIndexes
        let indexes = self.indexes.symmetricDifference(selected)
        self.setSelectionIndexes(indexes)
    }


}



extension NSArrayController {

    public var dictionaryRepresentation: JSON {
        set {

            do {
                let data = try ControllerData(object: newValue)
                self.content = data.arrangedObjects
                self.setSelectionIndexes(data.selectionIndexes)
//                self.selectionIndexes = data.selectionIndexes
            } catch {
                Swift.print("error = \(error)")
            }
//            let keys = RepresentationKey.keys.stringValues
//            keys.forEach({ self.setValue(newValue[$0], forKey: $0) })
        }
        get { return ControllerData(arrayController: self).marshaled() }
    }
}

enum RepresentationKey: Int, KeyType {
    case arrangedObjects
    case selectionIndexes

    var stringValue: String { return String(describing: self) }

    static var keys: [RepresentationKey] {
        return self.allCases(to: .selectionIndexes)
    }
}


struct ControllerData: Unmarshaling, Marshaling {
    typealias T = AnyObject
    let arrangedObjects: [String]
    let selectionIndexes: IndexSet

    // MARK: Init

    init(arrayController: NSArrayController) {
        self.arrangedObjects = arrayController.value(forKey: "arrangedObjects") as! [String]
        self.selectionIndexes = arrayController.value(forKey: "selectionIndexes") as! IndexSet
    }

    init(object: MarshaledObject) throws {
        self.arrangedObjects = try object.value(for: "arrangedObjects")
        self.selectionIndexes = try object.value(for: RepresentationKey.selectionIndexes)
    }

    func marshaled() -> JSON {
        let keys = [RepresentationKey.arrangedObjects, .selectionIndexes]

        return [
                RepresentationKey.arrangedObjects.stringValue : self.arrangedObjects,
                RepresentationKey.selectionIndexes.stringValue: self.selectionIndexes.marshaled()
        ]
    }


}

