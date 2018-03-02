//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public struct BearerEntityResponseSerializer<T: Decodable>: DataResponseSerializerProtocol {
	public typealias SerializedObject = (bearer: String, entity: T)

	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>
	
	public init(decodableType: T.Type = T.self) {
		self.serializeResponse = {
			let result = BearerDataSerializer.serializeResponseData(request: $0, response: $1, data: $2, error: $3)
			switch result {
				case .success(let token, let decodableData):
					let result = EntityResponseSerializer<T>.serializeResponseData(request: $0, response: $1, data: decodableData, error: $3)
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
	public static var bearerResponseSerializer: BearerEntityResponseSerializer<Self> {
		return BearerEntityResponseSerializer(decodableType: self)
	}
}

