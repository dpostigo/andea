//
// Created by Daniela Postigo on 1/8/18.
//

import Foundation
import Alamofire

public protocol CustomErrorResponseSerializer: CustomResponseSerializer {
	init(errorReporter: ErrorReporterProtocol.Type?)
	var serializeResponse: (URLRequest?, HTTPURLResponse?, Data?, Error?) -> Result<SerializedObject> { get set }
}

extension CustomErrorResponseSerializer  {
	public init(errorReporter: ErrorReporterProtocol.Type?) {
		self.init()
		guard let reporter = errorReporter else { return }
		let serializer = self.serializeResponse
		self.serializeResponse = {
			let result = serializer($0, $1, $2, $3)
			switch result {
				case .failure(let error) :
					reporter.record(error)
					return .failure(error)
				default: return result
			}
		}
	}
}

extension Alamofire.DataRequest {

	@discardableResult public func response<T: CustomErrorResponseSerializer>(queue: DispatchQueue? = nil, serializer: T.Type = T.self, completion: ((T.SerializedObject) -> Void)? = nil, failure: Failure? = nil) -> Self {
		return self.response(queue: queue, serializer: T.init(errorReporter: DataRequest.errorReporterClass()), completion: completion, failure: failure)
	}

	public static func errorReporterClass() -> ErrorReporterProtocol.Type? {
		return nil
	}

}
