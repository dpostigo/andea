//
// Created by Daniela Postigo on 7/22/17.
//

import Cocoa

extension NSObjectController {
    public var contentObject: Any? {
        get { return self.content }
        set {
            guard let value = newValue else { self.removeObject(self.content); return }
            self.addObject(value)
        }
    }

}
extension NSArrayController {

    public var contentArray: [Any]? {
        get { return self.content as? [Any] }
        set {
            guard let value = newValue else { self.removeAll(); return }
            self.add(contentsOf: value)
        }
    }

    // MARK: Init

    public convenience init(automaticallyRearrangesObjects: Bool, selectsInsertedObjects: Bool = false, avoidsEmptySelection: Bool = true) {
        self.init()
        self.automaticallyRearrangesObjects = automaticallyRearrangesObjects
        self.selectsInsertedObjects = selectsInsertedObjects
        self.avoidsEmptySelection = avoidsEmptySelection
    }

    public convenience init(representation data: [String: Any]) {
        self.init(); self.set(data: data)
    }

    func set(data: [String: Any]) {
        data.forEach({ element in
            guard let key = DictionaryKey(rawValue: element.key) else {
                self.setValue(element.value, forKey: element.key)
                return
            }

            let value = key.value(from: element.value)
            self.setValue(value, forKey: element.key)
        })
    }

    public func removeAll() {
        guard let content = self.content as? [Any] else { return }
        self.remove(contentsOf: content)
    }

    // MARK: Getters

    public var dictionaryRepresentation: [String: Any] {
        return self.dictionaryWithValues(forKeyPaths: DictionaryKey.all)
    }

    @objc open var arrayRepresentation: NSArray {
        return NSArray(array: self.sequenceRepresentation ?? [])
    }

    public var sequenceRepresentation: [Any]? {
        return self.arrangedObjects as? [Any]
    }

    // MARK: Archive

    func archive(identifier: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        UserDefaults.standard.set(data, forKey: identifier)
    }


    public convenience init?(forIdentifier identifier: String) {
        guard let data = UserDefaults.standard.data(forKey: identifier) else { return nil }
//        self = NSKeyedUnarchiver.unarchiveObject(with: data) as? NSArrayController
//
        let coder = NSKeyedUnarchiver(forReadingWith: data)
        self.init(coder: coder)
    }


}

open class ArrayController: NSArrayController {
    @objc open var identifier: String? {
        get { return self.value(forKey: "_identifier") as? String }
        set { self.setValue(newValue, forKey: "_identifier")}
    }

    @objc private var _identifier: String?

    override public init(content: Any?) {
        super.init(content: content)
        self.addObserver(self, forKeyPath: "_identifier", context: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        self.removeObserver(self, forKeyPath: "_identifier")
        DictionaryKey.all.forEach({ self.removeObserver(self, forKeyPath: $0.rawValue) })
    }

    // MARK: Key value observing

    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else { super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context); return }
        guard let type = DictionaryKey(rawValue: key) else { self.observe(key, of: object, change: change, context: context); return }

        switch type {
            case .automaticallyRearrangesObjects :
                break
            default: break
        }

    }

    func observe(_ key: String, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        switch key {
            case "_identifier":
                Swift.print("identifier = \(String(describing: identifier))")
                guard let identifier = self.identifier else { return }

                let data = UserDefaults.standard.value(forKey: identifier)
                Swift.print("data = \(String(describing: data))")

                DictionaryKey.all.forEach({
                    self.addObserver(self, forKeyPath: $0.rawValue, context: nil)
                })


                //            case let type = DictionaryKey(rawValue: key) :


            default: self.print(unhandledKey: key, object: object)
        }
    }

}


extension NSArrayController {
    public enum DictionaryKey: String, KeyPathProvider {
        case arrangedObjects = "content"
        case automaticallyRearrangesObjects
        case selectionIndexes
        case selectsInsertedObjects
        case sortDescriptors

        public var keyPathValue: String {
            switch self {
                case .arrangedObjects: return "arrayRepresentation"
                case .selectionIndexes: return "selectionIndexes.arrayRepresentation"
                default: return self.rawValue
            }
        }

        func value(from value: Any) -> Any {
            switch self {
                case .selectionIndexes: return IndexSet(value as! [Int])
                default: return value
            }
        }

        static var all: [DictionaryKey] {
            return [
                    .arrangedObjects,
                    .automaticallyRearrangesObjects,
                    .selectionIndexes,
                    .selectsInsertedObjects,
                    .sortDescriptors
            ]
        }
    }


}

