//
// Created by Daniela Postigo on 8/1/17.
//

import Foundation
import AppKit


open class CodableKeyedArchiver: NSKeyedArchiver {
    override open class func archivedData(withRootObject rootObject: Any) -> Data {
        Swift.print("\(type(of: self)).\(#function)")
        return super.archivedData(withRootObject: rootObject)
    }
}

extension NSKeyedArchiver {

	public static let NSArrayControllerKeys = ["content", "selectionIndexes"]



    
	class func archivedData(_ arrayController: NSArrayController, additionalKeys keys: [String] = NSKeyedArchiver.NSArrayControllerKeys) -> Data {
		let mutableData = NSMutableData()
		let archiver = NSKeyedArchiver(forWritingWith: mutableData)
		archiver.encodeRootObject(arrayController)
		archiver.encode(arrayController, forKeys: keys)
		archiver.finishEncoding()
		return mutableData as Data
	}

	open func encode(_ object: NSObject, forKeys keys: [String]) {
		keys.forEach({ self.encode(object.value(forKeyPath: $0), forKey: $0) })
	}
}



extension NSKeyedUnarchiver {

	open class func unarchiveObject(with data: Data, additionalKeys keys: [String] = NSKeyedArchiver.NSArrayControllerKeys) -> Any? {
		let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
		guard let result = unarchiver.decodeObject() as? NSObject else { return nil }
		unarchiver.decode(result, forKeys: keys)
		return result
	}

	open func decode(_ object: NSObject, forKeys keys: [String]) {
		keys.forEach({ self.decode(object, forKey: $0) })
	}

	open func decode(_ object: NSObject, forKey key: String) {
		guard let value = self.decodeObject(forKey: key) else { return }
		object.setValue(value, forKey: key)
	}
}


extension NSArrayController {


	open func archivedData(additionalKeys keys: [String] = NSKeyedArchiver.NSArrayControllerKeys) -> Data {
        return NSKeyedArchiver.archivedData(self, additionalKeys: keys)
	}

	open class func unarchive(_ data: Data, additionalKeys keys: [String] = NSKeyedArchiver.NSArrayControllerKeys) -> NSArrayController? {
        return NSKeyedUnarchiver.unarchiveObject(with: data, additionalKeys: keys) as? NSArrayController
	}

	open override func setValue(_ value: Any?, forKey key: String) {
		switch key {
			case "selectionIndexes": self.setSelectionIndexes(value as! IndexSet)
			default: super.setValue(value, forKey: key)
		}
	}

}
