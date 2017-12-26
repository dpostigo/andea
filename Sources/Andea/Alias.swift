//
// Created by Daniela Postigo on 7/24/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]
public typealias Block = () -> Void
public typealias Completion = () -> Void
public typealias Failure = (Error) -> Void



#if os(iOS)
	import UIKit
#elseif os(macOS)
	import AppKit
#endif

