//
// Created by Daniela Postigo on 6/21/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import Marshal

public struct Server: Unmarshaling {
    let root: URL

    let key: String
    let secret: String

    init() {
        let object = Bundle.main.infoDictionary!["server"] as! JSON
        try! self.init(object: object)
    }

    public init(object: MarshaledObject) throws {
        let root = try object.value(for: "root") as URL
        self.root = URL(string: "https://\(root)")!
        self.key = try object.value(for: "key")
        self.secret = try object.value(for: "secret")
    }

    // MARK: Public

    public static let shared = Server()
    public static var root: URL { return Server.shared.root }
//    public static var root: URL { return URL(string: "https://\(Server.shared.root)")! }

    public static var key: String { return Server.shared.key }
    public static var secret: String { return Server.shared.secret }

}


//fileprivate extension Server: Unmarshaling {
//    fileprivate init(object: MarshaledObject) throws {
//        self.root = try object.value(for: "root")
//        self.key = try object.value(for: "key")
//        self.secret = try object.value(for: "secret")
//    }
//
//}
