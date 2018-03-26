//
// Created by Daniela Postigo on 1/1/18.
//

import Foundation

extension Bundle {
	public enum error: Swift.Error {
		case typeMismatch(expected: Any, actual: Any)
		case fileNotFound
		case missingKey(String)
	}


	public func decode<Resource: Decodable>(_ decodableClass: Resource.Type = Resource.self, forKey key: String) throws -> Resource {
		return try JSONDecoder.decode(self.data(forKey: key))
	}

	public func data(forKey key: String) throws -> Data {
		guard let value = self.infoDictionary?[key] else {
			throw Bundle.error.missingKey(key)
		}
		return try JSONSerialization.data(withJSONObject: value)
	}

	public func decode<Resource: Decodable>(_ decodable: Resource.Type = Resource.self, forResource resource: String, withExtension ext: String) throws -> Resource {
		let data = try self.data(forResource: resource, withExtension: ext)
		switch ext {
			case "plist": return try PropertyListDecoder().decode(decodable, from: data)
			default: return try JSONDecoder().decode(decodable, from: data)
		}
	}

	public func data(forResource resource: String, withExtension: String) throws -> Data {
		let url = self.url(forResource: resource, withExtension: withExtension)!
		return try Data.init(contentsOf: url)
	}


	public func load(json jsonName: String, options: JSONSerialization.ReadingOptions = []) throws -> JSON {
		do {
			let data = try self.load(resource: jsonName, ext: "json")
            return try JSONSerialization.json(data: data, options: options)
		}
		catch { throw error }
	}

	public func load(resource filename: String, ext: String) throws -> Data {
		guard let file = Bundle.main.url(forResource: filename, withExtension: ext) else { throw Bundle.error.fileNotFound }
		return try Data(contentsOf: file)
	}
}


