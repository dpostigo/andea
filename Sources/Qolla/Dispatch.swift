//
// Created by Daniela Postigo on 3/17/18.
//

import Foundation

extension DispatchQueue {
    public static func after(deadline: DispatchTime, execute work: @escaping @convention(block) () -> Swift.Void) {
        self.main.asyncAfter(deadline: deadline, execute: work)
    }
}
