//
// Created by Daniela Postigo on 11/19/17.
// Copyright (c) 2017 DiagnosUs. All rights reserved.
//

import Foundation

extension URLRequest {
    public var authorizationHeader: AuthorizationHeader? {
        get {
            guard let auth = self.value(forHTTPHeaderField: "Authorization") else { return nil }
            return AuthorizationHeader(string: auth)
        }
        set { self.setValue(newValue?.string, forHTTPHeaderField: "Authorization") }
    }


    public mutating func authorizationHeader( _ value: AuthorizationHeader) -> URLRequest {
        self.authorizationHeader = value; return self
    }
}


public struct Password {
    public let username: String
    public let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}

public protocol Credentials { }

public struct Token: Credentials {
    public let string: String

    public init(string: String) {
        self.string = string
    }
}

public struct AuthorizationHeader {
    public let string: String

    public init(string: String) {
        self.string = string
    }
}

extension String {
    func makeBytes() -> [UInt8] {
        return Array<UInt8>(self.utf8)
    }
}

extension AuthorizationHeader {
    public var basic: Password? {
        guard let range = string.range(of: "Basic ") else {
            return nil
        }

#if swift(>=4)
        let token = string[range.upperBound...]


        let decodedToken = String(token).makeBytes().base64Decoded.makeString()
        guard let separatorRange = decodedToken.range(of: ":") else {
            return nil
        }

        let username = decodedToken[..<separatorRange.lowerBound]
        let password = decodedToken[separatorRange.upperBound...]

        return Password(username: String(username), password: String(password))
#else
        let token = string.substring(from: range.upperBound)

        let decodedToken = token.makeBytes().base64Decoded.makeString()
        guard let separatorRange = decodedToken.range(of: ":") else {
        return nil
        }

        let username = decodedToken.substring(to: separatorRange.lowerBound)
        let password = decodedToken.substring(from: separatorRange.upperBound)

        return Password(username: username, password: password)
#endif
    }

    public init(basic: Password) {
        let credentials = "\(basic.username):\(basic.password)"
        let encoded = credentials.makeBytes().base64Encoded.makeString()
        self.init(string: "Basic \(encoded)")
    }
}

extension AuthorizationHeader {
    public var bearer: Token? {
        guard let range = string.range(of: "Bearer ") else {
            return nil
        }

#if swift(>=4)
        let token = string[range.upperBound...]
        return Token(string: String(token))
#else
        let token = string.substring(from: range.upperBound)
        return Token(string: token)
#endif
    }

    public init(bearer: Token) {
        self.init(string: "Bearer \(bearer.string)")
    }
}
