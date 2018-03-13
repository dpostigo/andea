//
// Created by Daniela Postigo on 3/13/18.
//

import Foundation

public protocol ZeroDataProtocol: class {

}


extension ZeroDataProtocol where Self: UIViewController {
    
    public static func backgroundView<T: RangeReplaceableCollection>( _ items: T?) -> UIView? {
        let items = items ?? T.init()
        return items.isEmpty ? self.init().view : nil
    }
}

extension RangeReplaceableCollection {
    public func backgroundView<T: ZeroDataProtocol>(_ viewControllerClass: T.Type = T.self) -> UIView? where T: UIViewController {
        return viewControllerClass.backgroundView(self)
    }
}

extension UITableView {
    public func backgroundView<T: RangeReplaceableCollection, V: ZeroDataProtocol>(_ items: T? , viewControllerClass: V.Type = V.self) -> UIView? where V: UIViewController {
        return viewControllerClass.backgroundView(items)
    }
}