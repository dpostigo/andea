//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public struct BearerResponseSerializer: CustomResponseSerializer {
	public typealias SerializedObject = (bearer: String, data: Data)

	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
		self.serializeResponse = {  _, response, data, error in
			let result = Request.serializeResponseData(response: response, data: data, error: error)
			switch result {
				case .success(let data):
					if let token = response?.authorization { return .success((bearer: token, data: data)) }
					else { return .failure(BearerResponseError.bearerTokenMissing) }
				case .failure(let error): return .failure(error)
			}
		}
	}
}

public enum BearerResponseError: Swift.Error {
	case bearerTokenMissing
}

