//
// Created by Daniela Postigo on 4/2/18.
//

import Foundation

extension UITableViewHeaderFooterView {
    public convenience init(contentView: UIView, frame: CGRect) {
        self.init(frame: frame)
        self.contentView.embed(contentView, from: self.contentView.safeAreaLayoutGuide)
        self.sizeToSystemLayoutHeight(to: frame)
    }
}
