//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

extension ResourceEndpoint {
	public typealias nested = NestedResourceEndpoint
}

public enum NestedResourceEndpoint<Resource: ResourceProtocol, Nested: ResourceProtocol>: URLRequestConvertible {
	case get(Resource, Nested.Type)
	case post(Resource, Nested.Type)

	var root: URL { return URL(string: Resource.hostname)! }

	public func asURLRequest() throws -> URLRequest {
		let resource = self.resource

		let request = try URLRequest(url: self.asURL(), method: resource.method)

		switch self {
			case .get: return request
			case .post(let resource, _) :
				return try Alamofire.JSONEncoding.default.encode(request, withJSONObject: JSONSerialization.jsonObject(with: resource))
		}
	}


	private var resource: ResourceEndpoint<Resource> {
		switch self {
			case let .get(resource, _): return ResourceEndpoint.get(resource.identifier)
			case let .post(resource, _): return .post(resource)
		}
	}

	private func asURL() throws -> URL {
		switch self {
			case let .get(_, nested): return try self.resource.asURL().appendingPathComponent(nested.route)
			case let .post(resource, nested): return try ResourceEndpoint<Resource>.get(resource.identifier).asURL().appendingPathComponent(nested.route)
		}
	}
}
