//
// Created by Dani Postigo on 12/25/16.
//

import Foundation

extension DateFormatter {
    public convenience init(dateStyle: Style) {
        self.init(); self.dateStyle = dateStyle
    }

    public convenience init(dateFormat: String) {
        self.init(); self.dateFormat = dateFormat
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
