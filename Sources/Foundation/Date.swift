//
// Created by Daniela Postigo on 12/29/17.
//

import Foundation

extension Date {

	public var timeAgo: String {
		return self.timeAgo(true)
	}

	public func timeAgo(_ numeric: Bool = false) -> String {
		let now = Date()

		let flags: Set<Calendar.Component> = [ .minute, .hour, .day, .weekOfYear, .month, .year, .second]
		let components = Calendar.current.dateComponents(flags, from: self, to: now)


		switch components.year {
			case .some(let year) where year >= 2 : return "\(year) years ago"
			case .some(let year) where year >= 1 : return numeric ? "1 year ago" : "Last year"
			default: break
		}

		switch components.month {
			case .some(let month) where month >= 2 : return "\(month) months ago"
			case .some(let month) where month >= 1 : return numeric ? "1 month ago" : "Last month"
			default: break
		}

		switch components.weekOfYear {
			case .some(let week) where week >= 2 : return "\(week) weeks ago"
			case .some(let week) where week >= 1 : return numeric ? "1 week ago" : "Last week"
			default: break
		}

		switch components.day {
			case .some(let day) where day >= 2 : return "\(day) days ago"
			case .some(let day) where day >= 1 : return numeric ? "1 day ago" : "Yesterday"
			default: break
		}

		switch components.hour {
			case .some(let hour) where hour >= 2 : return "\(hour) hours ago"
			case .some(let hour) where hour >= 1 : return numeric ? "1 hour ago" : "An hour ago"
			default: break
		}

		switch components.minute {
			case .some(let minute) where minute >= 2 : return "\(minute) minutes ago"
			case .some(let minute) where minute >= 1 : return numeric ? "1 minute ago" : "A minute ago"
			default: break
		}

		switch components.second {
			case .some(let second) where second >= 3 : return "\(second) seconds ago"
			default: return "Just now"
		}
	}
}



