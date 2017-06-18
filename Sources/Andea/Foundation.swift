//
// Created by Dani Postigo on 4/8/17.
//

import Foundation

extension Bundle {
    public enum JSONLoadingError: Error {
        case fileNotFound
    }

    public func load(json filename: String) throws -> Any {
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else { throw JSONLoadingError.fileNotFound }
        do {
            let data = try Data(contentsOf: file)
            return try JSONSerialization.jsonObject(with: data, options: [])
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


