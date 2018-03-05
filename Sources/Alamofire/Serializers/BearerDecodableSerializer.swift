//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public struct BearerDecodableSerializer<T: Decodable>: DataResponseSerializerProtocol {
	public typealias SerializedObject = (bearer: String, entity: T)

	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>
	
	public init(decodableType: T.Type = T.self) {
		self.serializeResponse = {
			let result = Request.serializeResponse($0, $1, $2, $3, BearerDataSerializer.init())
			switch result {
				case .success(let token, let data):
					let result = Request.serializeResponse($0, $1, data, $3, DecodableSerializer<T>.init())
					// let result = DecodableResponseSerializer<T>.serializeResponseData(request: $0, response: $1, data: data, error: $3)
					switch result {
						case .success(let value): return .success((bearer: token, entity: value))
						case .failure(let error): return .failure(error)
					}
				case .failure(let error): return .failure(error)
			}
		}
	}
	
}

extension Decodable {
	public typealias BearerSerializer = BearerDecodableSerializer<Self>
	public static var bearerResponseSerializer: BearerSerializer {
		return BearerDecodableSerializer(decodableType: self)
	}
}

