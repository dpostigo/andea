//
//  ValueTransformer.swift
//  Pods
//
//  Created by Daniela Postigo on 8/23/17.
//

import Foundation

extension ValueTransformer {
    
    open class var valueTransformerName: NSValueTransformerName { return NSValueTransformerName(rawValue: String(describing: self)) }
    
    open class var arrayTransformer: ArrayTransformer<ValueTransformer> { return ArrayTransformer(transformer: self) }
    
    // MARK:
    
    open class func register(_ values: [ValueTransformer.Type]) {
        values.forEach({ self.register(class: $0) })
    }
    
    open class func register(class transformer: ValueTransformer.Type) {
        self.setValueTransformer(transformer.init(), forName: transformer.valueTransformerName)
    }
}



public final class ArrayTransformer<T: ValueTransformer>: ValueTransformer {
    open var transformer: T
    
    public init(transformer transformerType: T.Type) {
        self.transformer = transformerType.init()
        super.init()
    }
    
    open override class func transformedValueClass() -> AnyClass {
        return T.transformedValueClass()
    }
    
    open override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value as? [Any] else { return nil }
        return value.map({ self.transformer.transformedValue($0) })
    }
    
    open override class func allowsReverseTransformation() -> Bool {
        return T.allowsReverseTransformation()
    }
    
    open override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let value = value as? [Any] else { return nil }
        return value.map({ self.transformer.reverseTransformedValue($0) })
    }
}


open class URLTransformer: ValueTransformer {
    
    open override class func transformedValueClass() -> AnyClass {
        return NSURL.self
    }
    
    open override func transformedValue(_ value: Any?) -> Any? {
        guard let value = value as? String else { return nil }
        return URL(string: value)
    }
    
//    override class func allowsReverseTransformation() -> Bool {
//        return false
//    }
//
//    override func reverseTransformedValue(_ value: Any?) -> Any? {
//        guard let url = value as? URL else { return nil }
//        return url.absoluteString
//    }
}
