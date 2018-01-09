//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public enum ResourceEndpoint<Resource: ResourceProtocol>: Equatable, URLRequestConvertible, ResourceConvertibleProtocol {
	case index
	case get(Resource.Identifier)
	case post(Resource)
	case patch(Resource)
	case delete(Resource)

	var root: URL { return URL(string: Resource.hostname)! }

	var path: String {
		switch self {
			case .get(let id): return "\(id)"
			case .delete(let item): return "\(item.identifier)"
			default : return ""
		}
	}

	// MARK: URLConvertible

	func asURL() throws -> URL {
		return self.root.appendingPathComponent(Resource.route).appendingPathComponent(self.path)
	}

	// MARK: URLRequestConvertible

	public func asURLRequest() throws -> URLRequest {
		let url = try self.asURL()
		let request = try URLRequest(url: url, method: self.method)

		switch self {
			case .index:    return request
			case .get:      return request
			case .post(let item):
				return try Alamofire.JSONEncoding.default.encode(request, withJSONObject: JSONSerialization.jsonObject(with: item))
			case .patch:    return request
			case .delete:   return request

		}
	}

	// MARK: Equatable

	public static func ==(lhs: ResourceEndpoint<Resource>, rhs: ResourceEndpoint<Resource>) -> Bool {
		switch (lhs, rhs) {
			case (.index, .index) : return true
			case (.get(let lhs), .get(let rhs)) : return lhs == rhs
			case (.post(let lhs), .post(let rhs)) : return lhs == rhs
			case (.patch(let lhs), .patch(let rhs)) : return lhs == rhs
			case (.delete(let lhs), .delete(let rhs)) : return lhs == rhs
			default : return false
		}
	}
}



protocol ResourceConvertibleProtocol { }
extension ResourceConvertibleProtocol {
	var method: Alamofire.HTTPMethod {
		return ResourcePath(rawValue: Mirror.customReflect(self))!.method
	}
}

fileprivate enum ResourcePath: String {
	case index, list
	case get
	case post
	case patch
	case delete

	var method: Alamofire.HTTPMethod {
		switch self {
			case .index, .list: return .get
			default: return Alamofire.HTTPMethod(rawValue: self.rawValue.uppercased())!
		}
	}
}


