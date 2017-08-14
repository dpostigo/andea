//
// Created by Daniela Postigo on 8/1/17.
//

import AppKit

extension NSUserDefaultsController {

    public subscript(value: String) -> Any? {
        get { return self.value(forKeyPath: "values.\(value)") }
        set {
            guard let newValue = newValue else {self.defaults.removeObject(forKey: value); return}
            self.setValue(newValue, forKeyPath: "values.\(value)")
        }
    }
}


