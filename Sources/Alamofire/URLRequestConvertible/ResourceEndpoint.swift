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
	case last

	var method: Alamofire.HTTPMethod {
		switch self {
			case .index:    return .get
			case .last:     return .get
			default: return Alamofire.HTTPMethod(rawValue: Mirror.customReflect(self).uppercased())!
		}
	}

	public func asURLRequest() throws -> URLRequest {
		let request = try URLRequest(url: self.asURL(), method: self.method)
		switch self {
			case .index:    return request
			case .get:      return request
			case .post(let item):  return try self.encoding.encode(request, item)
			case .patch:    return request
			case .delete:   return request
			case .last:     return request
		}
	}

	// MARK: URLConvertible

	public func asURL() throws -> URL {
		var url = URL(string: Resource.hostname)!
		url.appendPathComponent(Resource.route)
		switch self {
			case .get(let id):      url.appendPathComponent("\(id)")
			case .delete(let item): url.appendPathComponent("\(item.identifier)")
			case .last:         url.appendPathComponent("last")
			default: break
		}
		return url
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


	var encoding: Alamofire.JSONEncoding {
		return Alamofire.JSONEncoding.default
	}
}



protocol ResourceConvertibleProtocol { }
extension ResourceConvertibleProtocol {
	var method: Alamofire.HTTPMethod {
		return ResourcePath(rawValue: Mirror.customReflect(self))!.method
	}
}

fileprivate enum ResourcePath: String {
	case index
	case list
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


