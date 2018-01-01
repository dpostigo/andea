//
// Created by Daniela Postigo on 8/1/17.
//

import AppKit

extension NSUserDefaultsController {
    
    public convenience init(name: String, initialValues: [String: Any]? = nil) {
        self.init(defaults: UserDefaults(suiteName: name), initialValues: initialValues)
    }
    
//    open override func bind(_ binding: NSBindingName, to observable: Any, withKeyPath keyPath: String, options: [NSBindingOption : Any]? = nil) {
//        let component = KeyPathComponent(rawValue: binding.rawValue)
//        switch component {
//            case .some(let .path(first, last)) where first == "values" : (self.values as AnyObject).bind(NSBindingName(rawValue: last.rawValue), to: observable, withKeyPath: keyPath, options: options)
//            default: super.bind(binding, to: observable, withKeyPath: keyPath, options: options)
//        }
//    }
    
    open func clear(_ keyPath: String) {
        self.setValue(nil, forKeyPath: "values.\(keyPath)")
    }
    
//    public subscript(value: String) -> Any? {
//        get { return self.value(forKeyPath: "values.\(value)") }
//        set {
//            guard let newValue = newValue else {self.defaults.removeObject(forKey: value); return}
//            self.setValue(newValue, forKeyPath: "values.\(value)")
//        }
//    }
}


