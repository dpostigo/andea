//
// Created by Dani Postigo on 4/8/17.
//

import Foundation

extension URLRequest {
    public init?(string: String, httpMethod: String? = nil) {
        guard let url = URL(string: string) else { return nil }
        self.init(url: url, httpMethod: httpMethod)
    }
    
    public init(url: URL, httpMethod: String?) {
        self.init(url: url)
        self.httpMethod = httpMethod
    }
}


extension Bundle {
    public enum BundleError: Error {
        case typeMismatch(expected: Any, actual: Any)
        case fileNotFound
    }


    public func load(plist name: String) throws -> JSON? {
        do {
            let data = try self.load(resource: name, ext: "plist")
            do {
                let plist = try PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                return plist as? JSON
            } catch {
                throw error
            }


        } catch { throw error }
    }


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

extension JSONSerialization {
    public enum JSONError: Error {
        case typeMismatch(expected: Any, actual: Any)
    }

    public class func json(with data: Data, options opt: JSONSerialization.ReadingOptions = []) throws -> [String: Any] {
        do {
            let value = try JSONSerialization.jsonObject(with: data, options: opt)
            guard let json = value as? JSON else { throw JSONError.typeMismatch(expected: [String: Any].self, actual: type(of: value)) }
            return json
        } catch { throw error }
    }
}

extension RangeReplaceableCollection {
    public func appending(_ item: Self.Iterator.Element) -> Self {
        var ret = Array(self) as! Self
        ret.append(item)
        return ret
    }
}

extension Array {
    public var indexSet: IndexSet {
        return IndexSet(integersIn: self.startIndex ... self.endIndex)
    }
}
extension Sequence {


    public func select(_ find: (Self.Iterator.Element) -> Bool) -> Self.Iterator.Element? {
        var generator = self.makeIterator()
        while let elem = generator.next() {
            if(find(elem)) {
                return elem
            }
        }
        return nil
    }
}


