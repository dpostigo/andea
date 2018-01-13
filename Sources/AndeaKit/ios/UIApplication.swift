//
// Created by Dani Postigo on 11/9/16.
//

import Foundation

#if os(iOS)
import UIKit

public let App = UIApplication.shared

extension UIApplication {
    // TODO:
//    public func sendSMS(number: String, message body: String = "") {
//        guard let sms = "sms:+\(number)&body=\(body)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else {
//            return
//        }
//
//        UIApplication.shared.openURL(URL(string: sms)!)
//    }
}

#elseif os(OSX)
import AppKit

public let App = NSApplication.shared()

#endif



extension Decodable {

    public static func from(bundleKey key: String) throws -> Self {
        let json = Bundle.main.object(forInfoDictionaryKey: key)
        return try self.from(json: json as Any)
    }

    public static func from(json: Any) throws -> Self {
        let data = try JSONSerialization.data(withJSONObject: json)
        return try JSONDecoder.decode(data)
    }
    
}

public struct Config: Decodable {
    public let root: String
    public let environment: Environment

    public init(root: String, environment: Environment) {
        self.root = root; self.environment = environment
    }

    public enum Environment: String, Codable {
        case debug
        case production
        case local
    }
}
