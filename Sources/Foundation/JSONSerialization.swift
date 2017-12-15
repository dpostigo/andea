//
//  JSONSerialization.swift
//  Pods
//
//  Created by Daniela Postigo on 8/26/17.
//

import Foundation

extension JSONSerialization {

    open class func string(_ obj: Any, options opt: JSONSerialization.WritingOptions = .prettyPrinted) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: obj, options: opt)
            return String(data: data, encoding: .utf8)!
        }
        catch { return String(describing: error) }
    }
}


extension Dictionary where Key == String {

    public var prettyPrinted: String {
        return JSONSerialization.string(self)
    }

}