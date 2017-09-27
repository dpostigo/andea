//
// Created by Daniela Postigo on 8/7/17.
//

import Cocoa

extension AnyKeyPath {
    
    open var itemIdentifier: NSUserInterfaceItemIdentifier? {
        guard let kvcString = self.kvcString else { return nil }
        return NSUserInterfaceItemIdentifier(rawValue: kvcString)
    }
    
    open var kvcString: String? {
        guard let value = self._kvcKeyPathString else { return nil }
        return "\(self.rootString).\(value)"
    }
    
    open var rootString: String { return String(describing: type(of: self).rootType) }
}

extension Sequence {
	public subscript<T>(valueKeyPath value: KeyPath<Element, T>) -> [T] {
		get { return self.map({ $0[keyPath: value] }) }
	}
}

extension Array {
	public subscript<T>(valueKeyPath path: WritableKeyPath<Element, T>) -> [T] {
		get {  return self[valueKeyPath: path as KeyPath] }
		set(newValue) {
			newValue.enumerated().forEach({ self[$0.offset][keyPath: path] = $0.element })
		}
	}
    
    public subscript<T>(valueKeyPath path: ReferenceWritableKeyPath<Element, T>) -> [T] {
        get {  return self[valueKeyPath: path as WritableKeyPath] }
        // set(newValue) {  self[valueKeyPath: path as WritableKeyPath] = newValue }
    }
}
