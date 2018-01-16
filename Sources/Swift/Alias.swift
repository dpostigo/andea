//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias Block = () -> Void
public typealias Completion = () -> Void
public typealias Failure = (Error) -> Void

public func customLog(name: String, value string: String, file: String = #file, line: Int = #line) {
	let base = file.split(separator: "/").last!
	let string = "[\(name)] \(base):\(line)  \(string)"
	NSLog(string)
	//	Swift.print("[\(name)] \(string) ( \(base):\(line) )")
}