//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public protocol CustomResponseSerializer: Alamofire.DataResponseSerializerProtocol {
	init()
}

extension CustomResponseSerializer {
	public static func serialize(_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?) -> Result<SerializedObject> {
		return self.serializeResponseData(request: request, response: response, data: data, error: error)
	}
	public static func serializeResponseData(request: URLRequest?, response: HTTPURLResponse?, data: Data?, error: Error?) -> Result<SerializedObject> {
		return self.init().serializeResponse(request, response, data, error)
	}
}


extension Alamofire.DataRequest {

	// MARK: BearerResponseSerializer
	
	@discardableResult public func responseBearer(completion: ((BearerResponseSerializer.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(serializerType: BearerResponseSerializer.self, completion: completion, failure: failure)
	}

	// MARK: EntityResponseSerializer

	@discardableResult public func responseEntity<Resource: Decodable>(_ decodableClass: Resource.Type = Resource.self, completion: ((EntityResponseSerializer<Resource>.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(serializerType: EntityResponseSerializer<Resource>.self, completion: completion, failure: failure)
	}

	// MARK: BearerResponseSerializer

	@discardableResult public func responseBearer<Resource: Decodable>(_ entityClass: Resource.Type = Resource.self, completion: ((BearerEntityResponseSerializer<Resource>.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(serializerType: BearerEntityResponseSerializer<Resource>.self, completion: completion, failure: failure)
	}

	// MARK: CustomResponseSerializer

	@discardableResult public func response<T: CustomResponseSerializer>(queue: DispatchQueue? = nil, serializerType: T.Type = T.self, completion: ((T.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(queue: queue, serializer: serializerType.init(), completion: completion, failure: failure)
	}

	@discardableResult public func response<T: CustomResponseSerializer>(queue: DispatchQueue? = nil, serializer: T, completion: ((T.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(queue: queue, responseSerializer: serializer) { response in
			switch response.result {
				case .success(let value): completion?(value)
				case .failure(let error): failure?(error)
			}
		}
	}

}
