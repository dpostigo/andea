//
// Created by Daniela Postigo on 6/22/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    public func wait() {
        self.waitForExpectations(timeout: 10000)
    }
}

public func XCTFail(_ error: Error, file: StaticString = #file, line: UInt = #line) {
    XCTFail("\(error)", file: file, line: line)
}
