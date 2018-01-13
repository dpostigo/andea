//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public enum EntityResponseSerializationError: Swift.Error {
	case jsonError(Swift.Error, Data)
	case decodingError(Swift.Error, Any)

}

public struct EntityResponseSerializer<T: Decodable> : CustomErrorResponseSerializer {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
		self.serializeResponse = {  _, response, data, error in
			let result = Request.serializeResponseData(response: response, data: data, error: error)
			switch result {
				case .success(let data):
					do { return .success(try T.decode(data)) }
					catch {
						return .failure(EntityResponseSerializationError.init(response, data, error))
					}
				case .failure(let error): return .failure(error)
			}
		}
	}

}

extension EntityResponseSerializationError {

	init(_ response: HTTPURLResponse?, _ data: Data, _ error: Swift.Error)  {
		let json = Request.serializeResponseJSON(options: .allowFragments, response: response, data: data, error: error)
		switch json {
			case .success(let json): self = .decodingError(error, json)
			case .failure(let jsonError): self = .jsonError(jsonError, data)
		}
	}
}

extension Alamofire.DataRequest {
	public static func decodableResponseSerializer<T: Decodable>() -> EntityResponseSerializer<T> { return EntityResponseSerializer() }
}


