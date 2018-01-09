//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public struct EntityResponseSerializer<T: Decodable> : CustomErrorResponseSerializer {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
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
	public static func decodableResponseSerializer<T: Decodable>() -> EntityResponseSerializer<T> { return EntityResponseSerializer() }
}


