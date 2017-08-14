//
// Created by Daniela Postigo on 8/1/17.
//

import Cocoa

public struct ArchiveHelper {
    public let key: String
    public let playground: String

    public let defaultsController: NSUserDefaultsController

    public init(key: String, playground: String) {
        self.key = key
        self.playground = playground
        self.defaultsController = NSUserDefaultsController(playground: self.playground)
    }



    // MARK: Methods

    //    func print(keyPath: String) {
    //        Swift.print("self.defaultsController.value(forKeyPath: \(keyPath) = \(String(describing: self.defaultsController.value(forKeyPath: keyPath)))")
    //    }
    //
    //    func print(countOf keyPath: String) {
    //        Swift.print("self.defaultsController.array(forKeyPath: \(keyPath)?.count = \(String(describing: self.defaultsController.array(forKeyPath: keyPath)?.count))")
    //
    //    }
    //    func printArray() {
    //        self.print(countOf: self.valuesKeyPath)
    //    }
    //
    //    func assert(countOf keyPath: String, _ count: Int) {
    //
    //        // self.defaultsController.assert(countOf: keyPath, count)
    //    }

    // MARK: Getters

    public var valuesKeyPath: String {
        return "values.\(self.key)"
    }

}

extension ArchiveHelper {
    public static var dummyArray: NSArray {
        return NSArray(array: self.dummyItems)
    }

    public static var dummyItems: [JSON] {
        return self.dummies(5)
    }


    public static func dummies(_ count: Int) -> [JSON] {
        return Array(repeating: self.dummyItem, count: count)

    }
    public static var dummyItem: JSON {
        var ret = [String : Any]()
        (0 ..< 3).forEach({ ret["Key\($0)"] = "Value\($0)" })
        return ret
    }
}


extension NSUserDefaultsController {
    public convenience init(playground: String, initialValues: [String: Any]? = nil) {
        let userDefaults = UserDefaults(suiteName: "com.dpostigo.playgrounds.\(playground)")!
        self.init(defaults: userDefaults, initialValues: initialValues)
    }
}
