//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import struct Alamofire.JSONEncoding
import protocol Alamofire.URLRequestConvertible

extension Alamofire.JSONEncoding {
    public func encode<Resource: Encodable>(_ request: URLRequestConvertible, withDecodable object: Resource) throws-> URLRequest {
        let json = try JSONSerialization.jsonObject(with: object)
        return try self.encode(request, withJSONObject: json)
    }
}

