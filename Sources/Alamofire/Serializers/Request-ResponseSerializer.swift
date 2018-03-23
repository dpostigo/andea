//
// Created by Daniela Postigo on 3/3/18.
//

import Foundation
import Alamofire

extension Request {
    
    public static func serialize<T: DataResponseSerializerProtocol>(_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?, _ responseSerializer: T) -> Result<T.SerializedObject> {
        return self.serializeResponse(request, response, data, error, responseSerializer)
    }
    
    public static func serializeResponse<T: DataResponseSerializerProtocol>(_ request: URLRequest?, _ response: HTTPURLResponse?, _ data: Data?, _ error: Error?, _ responseSerializer: T) -> Result<T.SerializedObject> {
        return self.serializeResponse(responseSerializer: responseSerializer, (request, response, data, error))
    }
    
    private static func serializeResponse<T: DataResponseSerializerProtocol>(responseSerializer: T, _ input: (URLRequest?, HTTPURLResponse?, Data?, Error?)) -> Result<T.SerializedObject> {
        switch (input.3, input.2) {
            case (.some, _ ):       return .failure(input.3!)
            case (.none, .none):    return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            case (.none, .some):    return responseSerializer.serializeResponse(input.0, input.1, input.2, input.3)
        }
    }
}


extension DataRequest {
    @discardableResult public func responseEntity<D: Decodable>(_ decodableClass: D.Type = D.self, queue: DispatchQueue? = nil, completionHandler: Result<D>.Item? = nil) -> Self {
        return self.response(queue: queue, responseSerializer: DecodableSerializer(decodableType: decodableClass)) {
            completionHandler?($0.result)
        }
    }
    
    @discardableResult
    public func result<T: DataResponseSerializerProtocol>(queue: DispatchQueue? = nil, responseSerializer: T, completionHandler: @escaping (Result<T.SerializedObject>) -> Void) -> Self {
        return self.response(queue: queue, responseSerializer: responseSerializer) { completionHandler($0.result) }
    }
    
}

