//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation

public protocol ErrorReporterProtocol {
	static func record(_ error: Error)
	static func record(_ error: Error, withAdditionalUserInfo userInfo: [String : Any]?)
}


