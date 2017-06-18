//
// Created by Dani Postigo on 11/9/16.
//

import Foundation

extension UIApplication {
	public func sendSMS(number: String, message body: String = "") {
		guard let sms = "sms:+\(number)&body=\(body)".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) else { return }
		UIApplication.shared.openURL(URL(string: sms)!)
	}
}
