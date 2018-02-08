//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias Block = (() -> ())
public typealias Completion = (() -> ())
public typealias Failure = ((Error) -> Void)


public enum CustomLog {
	public static func customLog(name: String, value: Any, file: String? = #file, line: Int? = #line) {
		let string = self.string(name, value, file: file, line: line)
		NSLog(string)
		Swift.print(string)
	}
	
	public static func print(name: String, value: Any, file: String = #file, line: Int? = #line) {
		Swift.print(self.string(name, value, file: file, line: line))
	}
	
	private static func string(_ name: String, _ value: Any, file: String?, line: Int?) -> String {
		var components = ["[\(name)]"]
		
		switch (file?.base, line) {
			case (.none, .none): break
			case (.some(let file), .none):
				components += [file]
			case (.none, .some(let line)):
				components += ["\(line)"]
			case (.some(let file), .some(let line)):
				components += ["\(file):\(line)"]
			
		}
		components += [String(describing: value)]
		return components.joined(separator: " ") as String
	}
	
	public static func printFunction(name: String, value: Any, caller: Any, function: StaticString = #function) {
		let string = "[\(name)] \(type(of: caller)).\(function), \(value)"
		Swift.print(string)
	}
	
}


extension String {
	
	fileprivate var base: String? {
        guard let split = self.split(separator: "/").last else { return nil }
        return String(split)
	}
}

enum Log {
	static func print(_ value: Any, _ file: String = #file, _ line: Int = #line) {
		CustomLog.print(name: "Andea", value: value, file: file, line: line)
	}
}
