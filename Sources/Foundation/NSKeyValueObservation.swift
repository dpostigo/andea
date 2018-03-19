//
// Created by Daniela Postigo on 3/18/18.
//

import Foundation

public class Observer<T: NSObject>: ObserverProtocol {
    public typealias Observed = T
    
    public weak var object: Observed?
    public var observations: [NSKeyValueObservation] = []
    
    public required init(_ object: Observed) {
        self.object = object
    }
}

public protocol ObserverProtocol: class {
    associatedtype Observed: NSObject
    
    init(_ object: Observed)
    var object: Observed? { get set }
    var observations: [NSKeyValueObservation] { get set }
    
}

extension ObserverProtocol {
    public typealias ChangeHandler<Value> = (Observed, NSKeyValueObservedChange<Value>) -> Void
    
    @discardableResult
    public func observe<Value>(_ keyPath: KeyPath<Observed, Value>, options: NSKeyValueObservingOptions = [], changeHandler: ChangeHandler<Value>? = nil) -> Self {
        let changeHandler = changeHandler ?? Self.changeHandler(keyPath)
        self.object.some { self.observations += $0.observe(keyPath, options: options, changeHandler: changeHandler) }; return self
    }
    
    public static func observe<Value>(_ object: Observed, keyPath: KeyPath<Observed, Value>, options: NSKeyValueObservingOptions = [], changeHandler: ChangeHandler<Value>? = nil) -> Self {
        return Self(object).observe(keyPath, options: options, changeHandler: changeHandler)
    }
    
    private static func changeHandler<Value>(_ keyPath: KeyPath<Observed, Value>, _ valueType: Value.Type = Value.self) -> ChangeHandler<Value> {
        return { value, change in
           
            keyPath.kvcString.some {
    
                Swift.print("Changed: \(String(describing: $0)), change = \(String(describing: change))")
            }
        }
    }
}

extension NSObjectProtocol where Self: NSObject  {
    public func observe<T: ObserverProtocol, Value>(keyPath: KeyPath<Self, Value>, changeHandler: ((Self, NSKeyValueObservedChange<Value>) -> Void)? = nil) -> T where T.Observed == Self {
        return T.observe(self, keyPath: keyPath, changeHandler: changeHandler)
    }
}
//
//extension NSKeyValueObservedChange: CustomDebugStringConvertible {
//
//    public var debugDescription: String {
//        let dict: [String: Any] = [
//            "kind" : self.kind,
//            "newValue" : self.newValue,
//            "oldValue" : self.oldValue,
//            "indexes" : self.indexes,
//            "isPrior": self.isPrior
//        ]
//        do {
//            let data = try JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted, .sortedKeys])
//            return String(data: data, encoding: .utf8) ?? ""
//        } catch {
//            return ""
//        }
//    }
//
//    enum CodingKeys: Int, Autorepresentable {
//        case kind
//        case newValue
//        case oldValue
//        case indexes
//        case isPrior
//    }
//}
//
//
//extension Dictionary where Key: CodingKey {
//
//    func debugDescription(options: JSONSerialization.WritingOptions = []) -> String {
//        let dict = self.map { ($0.key.stringValue, $0.value) }.dictionary
//        do {
//            let data = try JSONSerialization.data(withJSONObject: dict, options: [.prettyPrinted, .sortedKeys])
//            return String(data: data, encoding: .utf8) ?? ""
//        } catch {
//            return ""
//        }
//    }
//
//}
//
//extension Collection where Element == (String, Any) {
//
//    var dictionary: Dictionary<String, Any> {
//        return Dictionary(pairs: self)
//    }
//}
//

