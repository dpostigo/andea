//
// Created by Dani Postigo on 12/25/16.
//

import Foundation

extension DateFormatter {
    public convenience init(dateStyle: Style) {
        self.init(); self.dateStyle = dateStyle
    }
}

extension NumberFormatter {
    public convenience init(fraction: CountableClosedRange<Int>? = nil, integer: CountableClosedRange<Int>) {
        self.init()
        self.minimumFractionDigits = fraction?.lowerBound ?? 0
        self.maximumFractionDigits = fraction?.upperBound ?? 0
        self.minimumIntegerDigits = integer.lowerBound
        self.maximumIntegerDigits = integer.upperBound
    }

    public convenience init(numberStyle style: Style) {
        self.init()
        self.numberStyle = style
    }
}