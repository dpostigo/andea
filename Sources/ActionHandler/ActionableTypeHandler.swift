//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

class ActionableTypeHandler<ItemType: ActionableType> {
    private var handlers: [ItemType: ItemType.Handler] = [:]
    
    // MARK: Init
    
    init(actionType: ItemType.Type = ItemType.self) { }
    
    func itemHandler(_ item: ItemType) {
        self.handlers[item].some { $0(item) }
    }
    
    subscript(_ item: ItemType) -> ItemType.Handler? {
        get { return self.handlers[item] }
        set { self.handlers[item] = newValue }
    }
    
}


