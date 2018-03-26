//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import struct Alamofire.JSONEncoding
import protocol Alamofire.URLRequestConvertible

extension JSONEncoding {
    
    public static func encode<Resource: Encodable>(
        _ request: URLRequestConvertible,
        _ resource: Resource,
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
        dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64,
        outputFormatting: JSONEncoder.OutputFormatting = [],
        userInfo: [CodingUserInfoKey: Any]? = nil,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> URLRequest {
        return try self.default.encode(request, resource,
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            outputFormatting: outputFormatting,
            userInfo: userInfo,
            options: options
        )
    }
    public func encode<Resource: Encodable>(
        _ request: URLRequestConvertible,
        _ resource: Resource,
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
        dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64,
        outputFormatting: JSONEncoder.OutputFormatting = [],
        userInfo: [CodingUserInfoKey: Any]? = nil,
        options: JSONSerialization.ReadingOptions = []
    ) throws-> URLRequest {
        
        let json: Any = try resource.json(
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            outputFormatting: outputFormatting,
            userInfo: userInfo,
            options: options
        )
        return try self.encode(request, withJSONObject: json)
    }
}

