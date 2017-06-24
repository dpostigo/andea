//
// Created by Dani Postigo on 4/8/17.
//

import Foundation


extension Bundle {
    public enum JSONLoadingError: Error {
        case fileNotFound
    }


    public func load(plist name: String) throws -> JSON? {
        do {
            let data = try self.load(file: name, ext: "plist")
            do {
                let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
                return plist as? JSON
            } catch {
                throw error
            }


        } catch { throw error }
    }


    public func load(json filename: String, key: String? = nil) throws -> JSON? {
        do {
            let data = try self.load(file: filename, ext: "json")
//            if let json = JSONSerialization.jsonObject(with: data, options: []) {
//                return (json as? JSON)?[key ?? filename]
//            }
//            return nil

//            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) else { return nil };
//            return json as? JSON
            
            return try JSONSerialization.jsonObject(with: data, options: []) as? JSON
            
        }
        catch { throw error }
    }

    public func load(file filename: String, ext: String) throws -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: ext) else { throw JSONLoadingError.fileNotFound }
        do {
            return try Data(contentsOf: file)
        }
        catch { throw error }
    }
}

extension RangeReplaceableCollection {
    func appending(_ item: Self.Iterator.Element) -> Self {
        var ret = Array(self) as! Self
        ret.append(item)
        return ret
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


