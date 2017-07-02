//
// Created by Daniela Postigo on 6/30/17.
//

import Foundation

extension NSMutableParagraphStyle {
    public convenience init(lineSpacing: CGFloat) {
        self.init()
        self.lineSpacing = lineSpacing
    }

    public convenience init(alignment: NSTextAlignment) {
        self.init()
        self.alignment = alignment
    }

    public convenience init(lineSpacing: CGFloat, alignment: NSTextAlignment) {
        self.init()
        self.alignment = alignment
        self.lineSpacing = lineSpacing
    }
}