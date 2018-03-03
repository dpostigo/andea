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

extension DataResponseSerializerProtocol {

}

extension DataRequest {

	// MARK: BearerResponseSerializer
	
	@discardableResult public func responseBearer(completion: ((BearerDataSerializer.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(serializerType: BearerDataSerializer.self, completion: completion, failure: failure)
	}

	// MARK: EntityResponseSerializer

    @discardableResult public func responseEntity<D: Decodable>(_ decodableClass: D.Type = D.self, queue: DispatchQueue? = nil, completionHandler: Result<D>.Item? = nil) -> Self {
        let serializer = EntityResponseSerializer<D>.init()
		return self.response(queue: queue, responseSerializer: serializer) {
			completionHandler?($0.result)
		}
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

