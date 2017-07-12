//
// Created by Daniela Postigo on 7/12/17.
//

import Foundation
import Marshal

// MARK: Enum Unmarshaling
// eg. self.value = try object.value(for: Enum.case)

extension KeyType where Self: RawRepresentable, Self.RawValue == Int {
    public var stringValue: String { return String(describing: self) }
}

extension KeyType where Self: RawRepresentable, Self.RawValue == String {
    public var stringValue: String { return self.rawValue }
}