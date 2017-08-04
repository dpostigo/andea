//
// Created by Daniela Postigo on 8/3/17.
//

import Foundation
import AppKit

protocol ADArchivable {
    var codingKeys: [String] { get }
}
open class ADCustomArchiver2: NSKeyedArchiver {
	fileprivate enum ADArchiveType: String, ADArchivable {
		case arrayController

		init?(forController controller: Any) {
			switch controller {
				case is NSArrayController: self = .arrayController
				default: return nil
			}
		}

		var codingKeys: [String] {
			switch self {
				case .arrayController: return ["content", "selectionIndexes"]
				default: return []
			}
		}
	}

	override open class func archivedData(withRootObject rootObject: Any) -> Data {
		guard let archiveKind = ADArchiveType(forController: rootObject) else { return Data() }
		return self.archivedData(withRootObject: rootObject, keys: archiveKind.codingKeys)
	}

	open class func unarchiveObject(with data: Data) -> Any? {
		let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
		guard let result = unarchiver.decodeObject() else { return nil }
		unarchiver.decode(result as? NSObject, forKeys: ADArchiveType(forController: result)?.codingKeys)
		return result
	}
}

extension NSCoder {

	// MARK: Private encoding methods

	fileprivate class func archivedData(withRootObject rootObject: Any, keys: [String]) -> Data {
		let data = NSMutableData()
		let archiver = NSKeyedArchiver(forWritingWith: data)
		archiver.encode(rootObject, withKeys: keys)
		archiver.finishEncoding()
		return data as Data
	}

	fileprivate func encode(_ rootObject: Any, withKeys keys: [String]) {
		self.encodeRootObject(rootObject)
		self.encode(rootObject as! NSObject, forKeys: keys)
	}

	fileprivate func encode(_ object: NSObject, forKeys keys: [String]) {
		keys.forEach({ self.encode(object.value(forKeyPath: $0), forKey: $0) })
	}

	// MARK: Private decoding methods

	fileprivate func decode(_ object: NSObject?, forKeys keys: [String]?) {
		keys?.forEach({ self.decode(object, forKey: $0) })
	}

	fileprivate func decode(_ object: NSObject?, forKey key: String) {
		guard let value = self.decodeObject(forKey: key) else { return }
		object?.setValue(value, forKey: key)
	}
}


extension NSArrayController {
	open func archivedData() -> Data {
		return ADCustomArchiver2.archivedData(withRootObject: self)
	}
	open class func unarchive(_ data: Data) -> NSArrayController? {
		return ADCustomArchiver2.unarchiveObject(with: data) as? NSArrayController
	}

	open override func setValue(_ value: Any?, forKey key: String) {
		switch key {
			case "selectionIndexes": self.setSelectionIndexes(value as! IndexSet)
			default: super.setValue(value, forKey: key)
		}
	}
}

