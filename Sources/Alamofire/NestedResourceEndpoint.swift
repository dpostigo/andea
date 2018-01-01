//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

public enum NestedResourceEndpoint<Resource: ResourceProtocol, Nested: ResourceProtocol>: URLRequestConvertible {
	case get(Resource, Nested.Type)

	var root: URL { return URL(string: Resource.hostname)! }

	public func asURLRequest() throws -> URLRequest {
		switch self {
			case .get(let item, let nested):
				let resource = ResourceEndpoint<Resource>.get(item.identifier)
				let url = try resource.asURL().appendingPathComponent(nested.route)
				return try URLRequest(url: url, method: resource.method)
		}
	}
}
