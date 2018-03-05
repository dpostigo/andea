//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

extension Alamofire.DataRequest {
    public static func decodableResponseSerializer<T: Decodable>() -> DecodableSerializer<T> { return DecodableSerializer() }
}

public struct DecodableSerializer<T: Decodable> : DataResponseSerializerProtocol {
	public typealias SerializedObject = T
	public var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject>
    
    public init(decodableType: T.Type = T.self) {
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
