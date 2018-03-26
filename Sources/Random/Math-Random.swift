//
// Created by Daniela Postigo on 3/25/18.
//

import Foundation

// Credit: SwiftRandom, https://github.com/thellimist/SwiftRandom

public extension Int {
    /// SwiftRandom extension
    public static func random(_ range: Range<Int>) -> Int {
        return random(range.lowerBound, range.upperBound - 1)
    }
    
    /// SwiftRandom extension
    public static func random(_ range: ClosedRange<Int>) -> Int {
        return random(range.lowerBound, range.upperBound)
    }
    
    /// SwiftRandom extension
    public static func random(_ lower: Int = 0, _ upper: Int = 100) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}


public extension Double {
    /// SwiftRandom extension
    public static func random(_ lower: Double = 0, _ upper: Double = 100) -> Double {
        return (Double(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension Float {
    /// SwiftRandom extension
    public static func random(_ lower: Float = 0, _ upper: Float = 100) -> Float {
        return (Float(arc4random()) / 0xFFFFFFFF) * (upper - lower) + lower
    }
}

public extension CGFloat {
    /// SwiftRandom extension
    public static func random(_ lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
    }
}
