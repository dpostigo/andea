//
// Created by Daniela Postigo on 3/2/18.
//

import Foundation
import Alamofire
import protocol Alamofire.RequestAdapter
import class Alamofire.SessionManager

public final class HTTPHeaderAdapter: RequestAdapter {
    public var values: [HTTPHeader: String] = [:]
    
    public var token: String? {
        get { return self.values[.authorization] }
        set {
            switch newValue {
                case .none: self.values[.authorization] = newValue
                case .some(let token): self.values[.authorization] = "Bearer \(token)"
            }
        }
    }
    
    // MARK: RequestAdapter
    
    public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var request = urlRequest
        self.values.forEach { request[$0.key] = $0.value }
        return request
    }
    
    public required init() {
    }
    public convenience init(token: String? = nil) {
        self.init()
        ({ self.token = token })()
    }
    
}

extension SessionManager {
    public var httpHeaderAdapter: HTTPHeaderAdapter? { return self.adapter as? HTTPHeaderAdapter }
}
