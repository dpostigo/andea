//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public protocol ResourceProtocol: Equatable, Encodable {
	associatedtype Identifier: Equatable
	var identifier: Identifier { get }
	static var route: String { get }
	static var hostname: String { get }
}
