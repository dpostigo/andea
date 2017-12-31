//
// Created by Dani Postigo on 4/8/17.
//

import Foundation

extension URLRequest {
//    public init?(string: String, httpMethod: String? = nil) {
//        guard let url = URL(string: string) else { return nil }
//        self.init(url: url, httpMethod: httpMethod)
//    }
//    
//    public init(url: URL, httpMethod: String?) {
//        self.init(url: url)
//        self.httpMethod = httpMethod
//    }
}


extension Bundle {
    public enum BundleError: Error {
        case typeMismatch(expected: Any, actual: Any)
        case fileNotFound
    }


//    public func load(plist name: String) throws -> JSON? {
//        do {
//            let data = try self.load(resource: name, ext: "plist")
//            do {
//                let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
//                return plist as? JSON
//            } catch {
//                throw error
//            }
//
//
//        } catch { throw error }
//    }


    public func load(json jsonName: String, options opt: JSONSerialization.ReadingOptions = []) throws -> JSON {
        do {
            let data = try self.load(resource: jsonName, ext: "json")
            return try JSONSerialization.json(with: data, options: opt)
        }
        catch { throw error }
    }

    public func load(resource filename: String, ext: String) throws -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: ext) else { throw BundleError.fileNotFound }
        return try Data(contentsOf: file)
    }
}


