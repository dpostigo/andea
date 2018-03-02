//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public struct EntityResponseSerializer<T: Decodable> : CustomResponseSerializer {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>

	public init() {
		self.serializeResponse = {  _, response, data, error in
			let result = Request.serializeResponseData(response: response, data: data, error: error)
            switch result {
                case .success(let data):
                    do { return .success(try JSONDecoder.decode(T.self, from: data)) }
                    catch {
                        return .failure(error)
                    }
                case .failure(let error): return .failure(error)
            }
		}
	}

}


extension Alamofire.DataRequest {
	public static func decodableResponseSerializer<T: Decodable>() -> EntityResponseSerializer<T> { return EntityResponseSerializer() }
}


