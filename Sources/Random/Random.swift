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