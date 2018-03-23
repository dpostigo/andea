//
// Created by Daniela Postigo on 3/22/18.
//

import Foundation

open class ItemToolbar<T: UIBarButtonItemRepresentable> : ActionToolbar {
    public typealias ItemType = T
    open var itemHandler: ((ItemType) -> Void)?
    
    open var itemTypes: [ItemType] = [] {
        didSet { self.items = self.itemTypes.barButtonItems }
    }
    
    open subscript(_ item: ItemType) -> UIBarButtonItem? {
        get { return self[item.rawValue] }
        set { self[item.rawValue] = newValue }
    }
    
    // MARK: Init
   
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.itemTypes = ItemType.all
    }
    
    // MARK: Convenience
    
    public convenience init(items: [ItemType] = ItemType.all, itemTypeHandler: ((ItemType) -> Void)? = nil) {
        self.init()
        self.itemTypes = items
        self.itemHandler = itemTypeHandler
    }
   
    open override func selected(_ index: Int) {
        super.selected(index)
        self.selected(self.itemTypes[index])
    }
    
    open func selected(_ item: ItemType) {
        self.itemHandler?(item)
    }
}

extension UIBarButtonItemRepresentable {
    public static var toolbar: ItemToolbar<Self> {
        return self.toolbar()
    }
    
    public static func toolbar(itemTypeHandler: Handler? = nil) -> ItemToolbar<Self> {
        return ItemToolbar(itemTypeHandler: itemTypeHandler)
    }
}
