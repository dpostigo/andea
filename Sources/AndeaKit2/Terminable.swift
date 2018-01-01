//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation

public protocol Terminable: RawRepresentable {
    static var terminus: Self { get }
}

extension Terminable where RawValue == Int  {
    public static var breadth: [Self] {
        return self.allCases(to: self.terminus)
    }
}
