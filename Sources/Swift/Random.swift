//
// Created by Daniela Postigo on 1/1/18.
//

import Foundation

 extension Bool {
	public static var random: Bool { return Int.random() % 2 == 0 }
}

extension Array {
	public var random: Iterator.Element {
		precondition(!self.isEmpty)
		return self[Int.random(0 ... self.count - 1)]
	}
}

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


public extension Date {
	/// SwiftRandom extension
	public static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
		let today = Date()
		let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)

		let r1 = arc4random_uniform(UInt32(days))
		let r2 = arc4random_uniform(UInt32(23))
		let r3 = arc4random_uniform(UInt32(59))
		let r4 = arc4random_uniform(UInt32(59))

		var offsetComponents = DateComponents()
		offsetComponents.day = Int(r1) * -1
		offsetComponents.hour = Int(r2)
		offsetComponents.minute = Int(r3)
		offsetComponents.second = Int(r4)

		guard let rndDate1 = gregorian.date(byAdding: offsetComponents, to: today) else {
			print("randoming failed")
			return today
		}
		return rndDate1
	}

	/// SwiftRandom extension
	public static func random() -> Date {
		let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
		return Date(timeIntervalSince1970: randomTime)
	}

}


public extension URL {
	/// SwiftRandom extension
	public static var random: URL {
		let urlList = ["http://www.google.com", "http://leagueoflegends.com/", "https://github.com/", "http://stackoverflow.com/", "https://medium.com/", "http://9gag.com/gag/6715049", "http://imgur.com/gallery/s9zoqs9", "https://www.youtube.com/watch?v=uelHwf8o7_U"]
		return URL(string: urlList.random)!
	}
}

#if os(iOS)
public extension UIColor {
	/// SwiftRandom extension
	public static func random(_ randomAlpha: Bool = false) -> UIColor {
		let randomRed = CGFloat.random()
		let randomGreen = CGFloat.random()
		let randomBlue = CGFloat.random()
		let alpha = randomAlpha ? CGFloat.random() : 1.0
		return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: alpha)
	}
}
#endif