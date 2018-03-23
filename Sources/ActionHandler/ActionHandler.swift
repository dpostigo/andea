//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation
import UIKit

public class ActionHandler {
    public static let shared = ActionHandler()
    let barButtonItemActionHandler: ActionableTypeHandler = ActionableTypeHandler(actionType: UIBarButtonItem.self)
    
    // MARK: Init
    
    private init() { }
    
    // MARK: Subscripts
    
    subscript<T: ActionableType>(_ item: T) -> ((T) -> Void)? {
        get { return self.itemHandler(item) }
        set { self.set(itemHandler: newValue, forItem: item) }
    }
    
    // MARK: Private
    
    private func set<T: ActionableType>(itemHandler newValue: ((T) -> Void)?, forItem item: T) {
        switch item {
            case let item as UIBarButtonItem:
                item.target = self
                item.action = self.selector(item)
            default: break
        }
        self.handler(item).some { $0[item] = newValue }
    }
    
    
    private func itemHandler<T: ActionableType>(_ item: T) -> ((T) -> Void)? {
        return self.handler(item)?[item]
    }
    
    private func handler<T: ActionableType>(_ item: T) -> ActionableTypeHandler<T>? {
        switch item {
            case is UIBarButtonItem: return self.barButtonItemActionHandler as? ActionableTypeHandler<T>
            default: return nil
        }
    }
    
    
    // MARK: Selectors
    
    @objc(barButtonItemHandler:)
    private func barButtonItemHandler(_ item: UIBarButtonItem) {
        self.barButtonItemActionHandler.itemHandler(item)
    }
    
    private func selector<T: ActionableType>(_ item: T) -> Selector? {
        switch item {
            case is UIBarButtonItem: return #selector(self.barButtonItemHandler(_:))
            default: return nil
        }
    }
}

