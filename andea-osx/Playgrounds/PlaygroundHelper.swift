//
//  PlaygroundHelper.swift
//  Andea
//
//  Created by Daniela Postigo on 8/7/17.
//

import Foundation
import XCTest


extension XCTestSuite {
    class func run(_ tests: AnyClass) { XCTestSuite(forTestCaseClass: tests).run() }
}
extension XCTestCase {
    public class func run() {  XCTestSuite(forTestCaseClass: self).run() }
}

public class PlaygroundHelper {
    private var blocks1 = [() -> ()]()
    private var names: [String] = []
//    private var blocks: [String: () -> ()] = [:]
    
    
    public init(_ value: [() -> ()] = []) {
        self.blocks1 = value
        self.names = self.blocks1.map({ _ in "testFunction" })
    }
    
    public func append(_ name: String = "testFunction", _ value: @escaping (() -> ())) {
        self.names.append(name)
        self.blocks1.append(value)
    }
    
    
    
    public func execute() {
        self.blocks1.enumerated().forEach({
            Swift.print("PlaygroundHelper.\(self.names[$0.offset])()")
            $0.element()
        })
    }
}
