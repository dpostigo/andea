//
// Created by Daniela Postigo on 8/3/17.
//

import Cocoa

public protocol ADArchivable2 {
	// associatedtype CodingKeys: RawRepresentable where Coding
}
public protocol ADArchivableType {
	var object: Any { get }
	var codingKeys: [String] { get }
}

fileprivate enum ADArchiveType: String, ADArchivable {
	case encodable
	case arrayController

	init?(forObject object: Any) {
		switch object {
			case is NSArrayController: self = .arrayController
			default: return nil
		}

		let arrayController = object as! NSArrayController
	}

	var codingKeys: [String] {
		switch self {
			case .arrayController: return ["content", "selectionIndexes"]
			default: return []
		}
	}
}

fileprivate struct ADArchiveInfo: ADArchivableType {
	let object: Any

	private let archiveType: ADArchiveType

	init(_ object: Any) {
		self.object = object
		self.archiveType = ADArchiveType(forObject: self.object)!
	}

	var codingKeys: [String] {
		//		return self.archiveType.codingKeys
		switch self.object {
			case is NSArrayController: return ["content", "selectionIndexes"]
			default: return []
		}
	}
}




open class ADKeyedArchiver: NSKeyedArchiver {



	override open class func archivedData(withRootObject rootObject: Any) -> Data {
		return ADKeyedArchiver(rootObject: rootObject).encodedData
		// guard let kind = ADKeyedType(forObject: rootObject) else { return super.archivedData(withRootObject: rootObject) }
//
//		switch kind {
//			case .encodable : return ADKeyedArchiver(rootObject: rootObject).encodedData
//			default: break
//		}
//		return super.archivedData(withRootObject: rootObject)
	}

	convenience init(rootObject: Any) {
		self.init(forWritingWith: NSMutableData())
		self.encodeRootObject(rootObject)
		self.finishEncoding()
	}

	override init(forWritingWith data: NSMutableData) {
		Swift.print("\(type(of: self)).\(#function)")
		super.init(forWritingWith: data)
	}
    override open func encodeConditionalObject(_ object: Any?) {
		object
		super.encodeConditionalObject(object)
	}

    override open func encode(_ object: Any?) {
		guard let kind = ADKeyedType(forObject: object), let value = object else { return super.encode(object) }
		switch kind {
			case .encodable: self.encodeEncodable(value as! Encodable)
			case .arrayController:

				Swift.print("is arrayController")
				break
			default: super.encode(value)
		}
	}

	func encodeEncodable(_ encodable: Encodable) {
		do {
			self.encode(try encodable.encodedData())
			self.encode(NSStringFromClass(type(of: encodable) as! AnyClass), forKey: "ADClassName")
		} catch {
			error
		}
	}

    override open func encode(_ data: Data) {
		data
		super.encode(data)
	}

    override open func encodeRootObject(_ rootObject: Any) {
		rootObject
		super.encodeRootObject(rootObject)
	}

    override open func encodeValue(ofObjCType type: UnsafePointer<Int8>, at addr: UnsafeRawPointer) {
		type
		super.encodeValue(ofObjCType: type, at: addr)
	}

}

open class ADKeyedUnarchiver: NSKeyedUnarchiver {
	open override class func unarchiveObject(with data: Data) -> Any? {
		return super.unarchiveObject(with: data)
	}
	open override class func unarchiveObject(withFile path: String) -> Any? {
		return super.unarchiveObject(withFile: path)
	}
	public override init(forReadingWith data: Data) {
		super.init(forReadingWith: data)
	}
	open override var delegate: NSKeyedUnarchiverDelegate? {
		get {
			return super.delegate
		}
		set {
			super.delegate = newValue
		}
	}
	open override func finishDecoding() {
		super.finishDecoding()
	}
	open override class func setClass(_ cls: AnyClass?, forClassName codedName: String) {
		super.setClass(cls, forClassName: codedName)
	}
	open override func setClass(_ cls: AnyClass?, forClassName codedName: String) {
		super.setClass(cls, forClassName: codedName)
	}
	open override class func `class`(forClassName codedName: String) -> AnyClass? {
		return super.class(forClassName: codedName)
	}
	open override func `class`(forClassName codedName: String) -> AnyClass? {
		return super.class(forClassName: codedName)
	}
	open override func containsValue(forKey key: String) -> Bool {
		return super.containsValue(forKey: key)
	}
	open override func decodeBool(forKey key: String) -> Bool {
		return super.decodeBool(forKey: key)
	}
	open override func decodeInt32(forKey key: String) -> Int32 {
		return super.decodeInt32(forKey: key)
	}
	open override func decodeInt64(forKey key: String) -> Int64 {
		return super.decodeInt64(forKey: key)
	}
	open override func decodeFloat(forKey key: String) -> Float {
		return super.decodeFloat(forKey: key)
	}
	open override func decodeDouble(forKey key: String) -> Double {
		return super.decodeDouble(forKey: key)
	}
	open override func decodeData() -> Data? {
		return super.decodeData()
	}

}

open class ADCustomArchiver: NSCoder {
	open class func archivedData(withRootObject rootObject: Any) -> Data {
		return ADKeyedArchiver.archivedData(withRootObject: rootObject)
	}

	private class func archive(encodableObject rootObject: Encodable) -> Data {
		let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
		let objectData = try! rootObject.encodedData()
		archiver.encodeRootObject(objectData)
		archiver.encode(NSStringFromClass(type(of: rootObject) as! AnyClass), forKey: "ADClassName")
		archiver.finishEncoding()
		return archiver.encodedData
	}

	open class func unarchiveObject(with data: Data) -> Any? {
		let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
		let name = unarchiver.decodeObject(forKey: "ADClassName") as! String
		let decodedObjectData = unarchiver.decodeData()!
		let decodableType = NSClassFromString(name) as! Decodable.Type
		let result = try? decodableType.rootObject(decodedObjectData)
		return result
	}

	private class func unarchiveObject(_ data: Data, withName name: String) -> Any? {
		let decodableType = NSClassFromString(name) as! Decodable.Type
		let result = try? decodableType.rootObject(data)
		return result
	}
}








fileprivate enum ADKeyedType: RawRepresentable {
	case none
	case arrayController(NSArrayController)
	case encodable
	case decodable

	init?(forObject rootObject: Any?) {
		guard let value = rootObject else { return nil }
		switch value {
			case is NSArrayController: self = .arrayController(value as! NSArrayController)
			case is Encodable: self = .encodable
			default: return nil
		}
	}


	init?(rawValue: String) { return nil }
	var rawValue: String {
		return self.stringRepresentation
	}

	enum ADKeyedBase: String {
		case none
		case arrayController
		case encodable
		case decodable
	}
}
