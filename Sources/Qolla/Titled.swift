//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

public protocol Titled {
    var title: String { get }
}

extension Sequence where Element: Titled {
    public var titles: [String] { return self.map { $0.title } }
}

extension RawRepresentable where RawValue == Int, Self: Titled {
    
    public init?(title: String) {
        switch Self.titles.index(of: title) {
            case .none: return nil
            case .some(let index): self.init(rawValue: index)
        }
    }
    
    public var title: String {
        return self.stringValue.capitalized
    }
    
    public static var titles: [String] {
        return self.all.titles
    }
}
