//
// Created by Dani Postigo on 12/25/16.
//

import Foundation

extension DateFormatter {

    public convenience init(dateStyle: DateFormatter.Style) {
        self.init(); self.dateStyle = dateStyle
    }
    public convenience init(timeStyle: DateFormatter.Style) {
        self.init(); self.timeStyle = timeStyle
    }

    public convenience init(dateFormat: String) {
        self.init(); self.dateFormat = dateFormat
    }

    public static let iso8601Full: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()

	@available(OSX 10.12, *)
	public class var iso8601: ISO8601DateFormatter {
        return ISO8601DateFormatter(timeZone: TimeZone.autoupdatingCurrent)
    }

}

@available(OSX 10.12, *)
extension ISO8601DateFormatter {
    public convenience init(timeZone: TimeZone) {
        self.init(); self.timeZone = timeZone
    }
}

extension NumberFormatter {
    public typealias MinMax = (min: Int, max: Int)
    public convenience init(fraction: MinMax? = nil, integer: MinMax) {
        self.init()
        self.minimumFractionDigits = fraction?.min ?? 0
        self.maximumFractionDigits = fraction?.max ?? 0
        
        self.minimumIntegerDigits = integer.min
        self.maximumIntegerDigits = integer.max
    }

    public convenience init(numberStyle style: Style) {
        self.init()
        self.numberStyle = style
    }
}

extension DateFormatter {
    public class var shortDate: DateFormatter { return DateFormatter(dateStyle: .short) }
    public class var mediumDate: DateFormatter { return DateFormatter(dateStyle: .medium) }
    public class var longDate: DateFormatter { return DateFormatter(dateStyle: .long) }
    public class var fullDate: DateFormatter { return DateFormatter(dateStyle: .full) }

    public class var shortTime: DateFormatter { return DateFormatter(timeStyle: .short) }
    public class var mediumTime: DateFormatter { return DateFormatter(timeStyle: .medium) }
    public class var longTime: DateFormatter { return DateFormatter(timeStyle: .long) }
    public class var fullTime: DateFormatter { return DateFormatter(timeStyle: .full) }
}
