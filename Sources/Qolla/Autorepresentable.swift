//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

extension Autorepresentable {
    public static func count(_ element: Self) -> [Self] {
        return (element.rawValue + 1).times.flatMap { self.init(rawValue: $0) }
    }
}
