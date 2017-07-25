//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation

public protocol DeserializableModel { }

extension DeserializableModel where Self: RawRepresentable, Self.RawValue == String {
    public init?(identifier: String) {
        guard let identifier = identifier.components(separatedBy: ".").first else { return nil }
        guard let value = Self(rawValue: identifier.lowercasedFirst) else { return nil }
        self = value
    }
}

enum AdaptableModelError: Error {
    case unimplemented
    case identifier(String)
}