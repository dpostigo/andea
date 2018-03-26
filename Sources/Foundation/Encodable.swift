//
// Created by Daniela Postigo on 3/26/18.
//

import Foundation

extension Encodable {
    public func encode(
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
        dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64,
        outputFormatting: JSONEncoder.OutputFormatting = [],
        userInfo: [CodingUserInfoKey: Any]? = nil
    ) throws -> Data {
        return try JSONEncoder.encode(self,
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            outputFormatting: outputFormatting,
            userInfo: userInfo
        )
    }
    
    public func json<T>(
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
        dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64,
        outputFormatting: JSONEncoder.OutputFormatting = [],
        userInfo: [CodingUserInfoKey: Any]? = nil,
        options: JSONSerialization.ReadingOptions = []
    ) throws -> T {
        return try JSONSerialization.json(data: self.encode(), options: options)
    }
}
extension JSONEncoder {
    class func encode<T: Encodable>(_ value: T, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate, dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64, outputFormatting: JSONEncoder.OutputFormatting = [], userInfo: [CodingUserInfoKey: Any]? = nil) throws -> Data {
        let encoder = JSONEncoder(
            dateEncodingStrategy: dateEncodingStrategy,
            dataEncodingStrategy: dataEncodingStrategy,
            outputFormatting: outputFormatting,
            userInfo: userInfo
        )
        return try encoder.encode(value)
    }
    
    convenience init(
        dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .deferredToDate,
        dataEncodingStrategy: JSONEncoder.DataEncodingStrategy = .base64,
        outputFormatting: JSONEncoder.OutputFormatting = [],
        userInfo: [CodingUserInfoKey: Any]? = nil
    ) {
        self.init()
        self.dateEncodingStrategy = dateEncodingStrategy
        self.dataEncodingStrategy = dataEncodingStrategy
        self.outputFormatting = outputFormatting
        userInfo.some { self.userInfo = $0 }
    }
}

