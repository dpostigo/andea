//
// Created by Daniela Postigo on 3/10/17.
// Copyright (c) 2017 Daniela Postigo. All rights reserved.
//

import Foundation
import Marshal
import Andea

struct Environment: Unmarshaling {
    static let shared = Environment()
    static var name: String { return Environment.shared.name }
    static var root: URL { return Environment.shared.root }
    static var loggingEnabled: Bool { return Environment.shared.loggingEnabled }

    let name: String
    let root: URL
    let loggingEnabled: Bool

    init() {
        let object = Bundle.main.infoDictionary!["environment"] as! JSON
        try! self.init(object: object)
    }

    init(object: MarshaledObject) throws {
        self.name = try object.value(for: "name")
        self.root = try object.value(for: "urls.root")
        self.loggingEnabled = Bool(try object.value(for: "settings.loggingEnabled"))!
    }
}
