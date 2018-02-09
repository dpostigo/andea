//
// Created by Daniela Postigo on 1/31/18.
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
}
