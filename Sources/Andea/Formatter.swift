//
// Created by Dani Postigo on 12/25/16.
//

import Foundation


extension DateFormatter {

    public convenience init(dateStyle: Style) {
        self.init(); self.dateStyle = dateStyle
    }
}
