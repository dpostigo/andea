//
// Created by Daniela Postigo on 8/7/17.
//

import Foundation


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
