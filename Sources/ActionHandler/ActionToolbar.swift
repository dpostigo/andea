//
// Created by Daniela Postigo on 3/23/18.
//

import Foundation

open class ActionToolbar : UIToolbar {
    open var handler: ((Int, UIBarButtonItem) -> Void)?
    open var indexHandler: ((Int) -> Void)?
    open var barButtonItemHandler: ((UIBarButtonItem) -> Void)?
    
    // MARK: Int
    
    open override var items: [UIBarButtonItem]? {
        get { return super.items }
        set {
            super.items = newValue
            self.items.some { $0.forEach { $0.actionHandler = self.selected } }
        }
    }
    
    public subscript(_ index: Int) -> UIBarButtonItem? {
        get { return self.items?[index] }
        set {
            self.items.some {
                var items = $0
                newValue.some { items[index] = $0 }
                self.items = items
            }
        }
    }
    
    open func selected(_ sender: UIBarButtonItem) {
        self.barButtonItemHandler?(sender)
        self.items?.index(of: sender).some { index in
            self.selected(index)
            self.selected(index, sender)
        }
    }
    
    open func selected(_ index: Int, _ sender: UIBarButtonItem) {
        self.handler?(index, sender)
    }
    
    open func selected(_ index: Int) {
        self.indexHandler?(index)
    }

}


