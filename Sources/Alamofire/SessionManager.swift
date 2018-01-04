//
// Created by Daniela Postigo on 12/27/17.
//

import Foundation
import Alamofire

extension SessionManager {

	@discardableResult public func nested<T: ResourceProtocol, Nested: ResourceProtocol & Decodable>( _ resource: T, _ nested: Nested.Type = Nested.self, completion: (([Nested]) -> Void)? = nil, failure: Failure? = nil) -> Alamofire.DataRequest {
		let request = self.request(ResourceEndpoint.nested.get(resource, Nested.self))
		request.responseEntity(completion, failure: failure)
		return request
	}
}
