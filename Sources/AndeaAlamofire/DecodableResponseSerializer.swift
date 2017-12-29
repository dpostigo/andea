//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public struct CustomDataResponseSerializer<T: Decodable> : DataResponseSerializerProtocol {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<T>

	public init(_ entity: T.Type = T.self) {
		self.serializeResponse = {  _, response, data, error in
			let result = Request.serializeResponseData(response: response, data: data, error: error)
			switch result {
				case .success(let data):
					do { return .success(try T.decode(data)) }
					catch { Swift.print(error); return .failure(error) }
				case .failure(let error): Swift.print(error); return .failure(error)
			}
		}
	}
}

extension Alamofire.DataRequest {
	public static func decodableResponseSerializer<T: Decodable>() -> CustomDataResponseSerializer<T> { return CustomDataResponseSerializer() }

	@discardableResult public func responseEntity<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
		return self.response(queue: queue, responseSerializer: DataRequest.decodableResponseSerializer(), completionHandler: completionHandler)
	}

	@discardableResult public func responseEntity<T: Decodable>(_ type: T.Type, completion: ((T) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.responseEntity(completion, failure: failure)
	}

	@discardableResult public func responseEntity<T: Decodable>(_ completion: ((T) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.responseEntity(completionHandler: { (response: DataResponse<T>) in
			switch response.result {
				case .success(let data) : completion?(data)
				case .failure(let error): failure?(error)
			}
		})
	}

}


