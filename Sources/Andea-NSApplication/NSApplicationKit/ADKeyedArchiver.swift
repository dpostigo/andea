//
// Created by Daniela Postigo on 8/3/17.
//

import Cocoa

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
		switch self.object {
			case is NSArrayController: return ["content", "selectionIndexes"]
			default: return []
		}
	}
}




fileprivate class ADKeyedArchiver: NSKeyedArchiver {



	override class func archivedData(withRootObject rootObject: Any) -> Data {
		return self.init(rootObject: rootObject).encodedData
		// guard let kind = ADKeyedType(forObject: rootObject) else { return super.archivedData(withRootObject: rootObject) }
//
//		switch kind {
//			case .encodable : return ADKeyedArchiver(rootObject: rootObject).encodedData
//			default: break
//		}
//		return super.archivedData(withRootObject: rootObject)
	}

 	required init(rootObject: Any) {
		Swift.print("\(type(of: self)).\(#function)")
		super.init(forWritingWith: NSMutableData())
		self.encodeRootObject(rootObject)
		self.encode(className: rootObject)
		self.finishEncoding()


	}



	func encode(className rootObject: Any) {
		if let object = rootObject as? NSObject {
			// let className = self.className(forObject: object)
            let className = object.className
			Swift.print("className = \(String(describing: className))")
			Swift.print("object.className = \(String(describing: object.className))")
			self.encode(className, forKey: "ADClassName")
		} else {

			Swift.print("did not encode class Name")
		}

	}

	func className(forObject object: Any) -> String? {
		guard let ref = type(of: object) as? AnyClass else { return nil }
		return NSStringFromClass(ref)
	}

    override func encodeConditionalObject(_ object: Any?) {
		object
		super.encodeConditionalObject(object)
	}

    override func encode(_ object: Any?) {
		guard let kind = ADKeyedType(forObject: object), let value = object else {
			return super.encode(object)

		}
		switch kind {
			case .encodable: self.encodeEncodable(value as! Encodable)
			default: super.encode(value)
		}
	}


	func encodeEncodable(_ encodable: Encodable) {
		do {self.encode(try encodable.encodedData())}
		catch {Swift.print("error = \(String(describing: error))")}
	}

    override func encode(_ data: Data) {
		data
		super.encode(data)
	}

    override func encodeRootObject(_ rootObject: Any) {
		rootObject
		super.encodeRootObject(rootObject)
	}

    override func encodeValue(ofObjCType type: UnsafePointer<Int8>, at addr: UnsafeRawPointer) {
		type
		super.encodeValue(ofObjCType: type, at: addr)
	}

}

class ADKeyedUnarchiver: NSKeyedUnarchiver {

	enum UnarchiverError: Error {
		case keyNotFound(String)
		case valueNotFound(Any.Type)

		case general(String)

		case generic
	}

	override class func unarchiveObject(with data: Data) -> Any? {
		Swift.print("\(type(of: self)).\(#function)")

		let unarchiver = ADKeyedUnarchiver(forReadingWith: data)

		do {
			let result = try unarchiver.decodeRootObject(withData: data)
			Swift.print("result = \(String(describing: result))")
            
            return result
		} catch {
			Swift.print("error = \(String(describing: error))")

			return super.unarchiveObject(with: data)
		}
		
//		let unarchiver1 = NSKeyedUnarchiver()
//		unarchiver1.decoded
//		let unarchiver = ADKeyedUnarchiver(forReadingWith: data)
//		let name = unarchiver.decodeObject(forKey: "ADClassName") as! String
//		let decodedObjectData = unarchiver.decodeData()!
//		let decodableType = NSClassFromString(name) as! Decodable.Type
//		let result = try? decodableType.rootObject(decodedObjectData)
//		return result
//
//
	}

	private let data: Data

	public override init(forReadingWith data: Data) {
		self.data = data
		super.init(forReadingWith: data)
	}


	var decodedObject: Any? {
		return try? self.decodeRootObject(withData: self.data)
	}

	func decodeRootObject(withData data: Data) throws -> Any {

		//		let unarchiver = ADKeyedUnarchiver(forReadingWith: data)
		//		let name = unarchiver.decodeObject(forKey: "ADClassName") as! String
		//		let decodedObjectData = unarchiver.decodeData()!
		//		let decodableType = NSClassFromString(name) as! Decodable.Type
		//		let result = try? decodableType.rootObject(decodedObjectData)
		//		return result

		guard let name = self.decodeObject(forKey: "ADClassName") as? String else {
			throw UnarchiverError.keyNotFound("ADClassName")
		}

		guard let decodedObjectData = self.decodeData() else {
			throw UnarchiverError.valueNotFound(Data.self)
		}


		return try self.decode(data: decodedObjectData, forClass: NSClassFromString(name)!)



	}

	func decode(data: Data, forClass aClass: Any.Type) throws -> Any {
		switch aClass {
			case is Decodable.Type:
				let decodableType = aClass as! Decodable.Type
				Swift.print("is Decodable")
				return try decodableType.rootObject(data)
			case is NSArrayController.Type:
				Swift.print("is NSArrayController")

				throw UnarchiverError.generic
            
			default : throw UnarchiverError.generic

		}
	}



	override func finishDecoding() {
		super.finishDecoding()
	}
	override class func setClass(_ cls: AnyClass?, forClassName codedName: String) {
		super.setClass(cls, forClassName: codedName)
	}
	override func setClass(_ cls: AnyClass?, forClassName codedName: String) {
		super.setClass(cls, forClassName: codedName)
	}
	override class func `class`(forClassName codedName: String) -> AnyClass? {
		return super.class(forClassName: codedName)
	}
	override func `class`(forClassName codedName: String) -> AnyClass? {
		return super.class(forClassName: codedName)
	}
	override func containsValue(forKey key: String) -> Bool {
		return super.containsValue(forKey: key)
	}
	override func decodeBool(forKey key: String) -> Bool {
		return super.decodeBool(forKey: key)
	}
	override func decodeInt32(forKey key: String) -> Int32 {
		return super.decodeInt32(forKey: key)
	}
	override func decodeInt64(forKey key: String) -> Int64 {
		return super.decodeInt64(forKey: key)
	}
	override func decodeFloat(forKey key: String) -> Float {
		return super.decodeFloat(forKey: key)
	}
	override func decodeDouble(forKey key: String) -> Double {
		return super.decodeDouble(forKey: key)
	}
	override func decodeData() -> Data? {
		return super.decodeData()
	}


}

open class ADCustomArchiver: NSCoder {
	open class func archivedData(withRootObject rootObject: Any) -> Data {
		return ADKeyedArchiver.archivedData(withRootObject: rootObject)
	}

//	private class func archive(encodableObject rootObject: Encodable) -> Data {
//		let archiver = NSKeyedArchiver(forWritingWith: NSMutableData())
//		let objectData = try! rootObject.encodedData()
//		archiver.encodeRootObject(objectData)
//		archiver.encode(NSStringFromClass(type(of: rootObject) as! AnyClass), forKey: "ADClassName")
//		archiver.finishEncoding()
//		return archiver.encodedData
//	}


	open class func unarchiveObject(with data: Data) -> Any? {
		return ADKeyedUnarchiver.unarchiveObject(with: data)
//		let unarchiver = ADKeyedUnarchiver(forReadingWith: data)
//		let name = unarchiver.decodeObject(forKey: "ADClassName") as! String
//		let decodedObjectData = unarchiver.decodeData()!
//		let decodableType = NSClassFromString(name) as! Decodable.Type
//		let result = try? decodableType.rootObject(decodedObjectData)
//		return result
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
