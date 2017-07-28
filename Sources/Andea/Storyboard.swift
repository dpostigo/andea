//
// Created by Daniela Postigo on 7/28/17.
//

import Foundation

#if os(iOS)
import UIKit

extension UIStoryboard {
    // public class var main: UIStoryboard { return UIStoryboard(name: UIStoryboard.Name(rawValue: "Main"), bundle: nil) }
//    public func viewController<T: UIViewController>(forClass type: T.Type) -> T? {
//        guard let identifier = String(describing: Swift.type(of: type)).components(separatedBy: ".").first else { return nil }
//        return self.instantiateController(withIdentifier: UIStoryboard.SceneIdentifier(rawValue: identifier)) as? T
//    }
}


#elseif os(macOS)
import AppKit

extension NSStoryboard {
    // public class var main: NSStoryboard { return NSStoryboard(name: NSStoryboard.Name(rawValue: "Main"), bundle: nil) }
    public func viewController<T: NSViewController>(forClass type: T.Type) -> T? {
        guard let identifier = String(describing: Swift.type(of: type)).components(separatedBy: ".").first else { return nil }
        return self.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier(rawValue: identifier)) as? T
    }
}

#endif


