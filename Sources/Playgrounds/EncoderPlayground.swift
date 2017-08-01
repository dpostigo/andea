//
// Created by Daniela Postigo on 7/1/17.
//

import Cocoa

public struct ENProductValue: Codable {
    public var name: String
    public var points: Int
    public var description: String
}

@objc open class ENProduct: NSObject, Codable {
    @objc public var name: String = ""
    @objc public var points: Int = 0

    public init(name: String, points: Int = 0) {
        self.name = name
        self.points = points
        super.init()
    }

    open class func dummies(_ count: Int) -> [ENProduct] {
        return (0 ..< count).map({ ENProduct(name: "Dummy \($0)") })
    }

    open class var dummyItem: ENProduct {
        return ENProduct(name: "Dummy")
    }

    open class var dummyData: Data {
        return """
        {
            "name": "Banana",
            "points": 200,
            "description": "A banana grown in Ecuador."
        }
        """.data(using: .utf8)!
    }
}


public enum EncoderPlayground {

    public static let userDefaults = UserDefaults(
            suiteName: "com.dpostigo.playgrounds.Encoder",
            initialValues: [
                "products": EncoderPlayground.itemsData,
                "productsJSON": EncoderPlayground.itemsJSON,
                "item1": EncoderPlayground.itemJSON
            ]
    )
    //    lazy var userDefaults: UserDefaults = ({
    //        return UserDefaults(
    //            suiteName: "com.dpostigo.playgrounds.Encoder",
    //            initialValues: [ "products": EncoderPlayground.itemsData, "item1": EncoderPlayground.itemJSON ]
    //        )
    //    })()
    //
    public static var userDefaultsController: NSUserDefaultsController {
        return NSUserDefaultsController(
                defaults: self.userDefaults,
                initialValues: nil
        )
    }

    public static let itemsJSON: [JSON] = [
        [
            "name" : "Banana",
            "points" : 200,
            "description" : "A banana grown in Ecuador."
        ],
        [
            "name" : "Orange",
            "points" : 100,
            "description" : "An orange."
        ]
    ]

    public static let itemsData: Data = """
[
{
"name": "Banana",
"points": 200,
"description": "A banana grown in Ecuador."
},
{
"name": "Orange",
"points": 100,
"description": "An orange."
}
]
""".data(using: .utf8)!

    public static let itemJSON = """
{
"name": "Banana",
"points": 200,
"description": "A banana grown in Ecuador."
}
""".data(using: .utf8)!
}
