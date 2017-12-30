//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation
import libc

#if os(Linux)
import Glibc
#else
import Darwin
#endif

#if os(Linux)
/// Generates a random number between (and inclusive of)
/// the given minimum and maximum.
private let randomInitialized: Bool = {
	/// This stylized initializer is used to work around dispatch_once
	/// not existing and still guarantee thread safety
	let current = Date().timeIntervalSinceReferenceDate
	let salt = current.truncatingRemainder(dividingBy: 1) * 100000000
	libc.srand(UInt32(current + salt))
	return true
}()
#endif

extension Int {
	static let maxByte: Int = Int(UInt8.max)

	public static func random( _ min: Int, _ max: Int) -> Int {
		let top = max - min + 1
#if os(Linux)
		// will always be initialized
		guard randomInitialized else { fatalError() }
		return Int(libc.random() % top) + min
#else
		var a = min
		var b = max
		if a > b { swap(&a, &b) } // swap to prevent negative integer crashes
		return Int(arc4random_uniform(UInt32(b - a + 1))) + a
#endif
	}

}
