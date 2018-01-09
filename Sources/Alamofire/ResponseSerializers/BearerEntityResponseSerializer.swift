//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public struct BearerEntityResponseSerializer<Resource: Decodable>: CustomErrorResponseSerializer {
	public typealias SerializedObject = (bearer: String, entity: Resource)

	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
		self.serializeResponse = {
			let result = BearerResponseSerializer.serializeResponseData(response: $1, data: $2, error: $3)
			switch result {
				case .success(let token, let decodableData):
					let result = EntityResponseSerializer<Resource>.serializeResponseData(response: $1, data: decodableData, error: $3)
					switch result {
						case .success(let value): return .success((bearer: token, entity: value))
						case .failure(let error): return .failure(error)
					}
				case .failure(let error): return .failure(error)
			}
		}
	}
}


