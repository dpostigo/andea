//
// Created by Daniela Postigo on 1/19/18.
//

import Foundation

public protocol Autorepresentable: CodingKey, RawRepresentable, Hashable where RawValue == Int { }
