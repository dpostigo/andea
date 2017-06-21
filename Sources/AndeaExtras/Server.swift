//
// Created by Daniela Postigo on 6/21/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import Marshal
import Andea

struct Server: Unmarshaling {
    let root: URL

    let key: String
    let secret: String

    init() {
        let object = Bundle.main.infoDictionary!["server"] as! JSON
        try! self.init(object: object)
    }

    init(object: MarshaledObject) throws {
        self.root = try object.value(for: "root")
        self.key = try object.value(for: "key")
        self.secret = try object.value(for: "secret")
    }

}

