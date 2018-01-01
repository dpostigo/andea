//
// Created by Daniela Postigo on 12/15/17.
//

import Foundation

open class SelectionContainer<Element: Equatable> {
	open var items: [Element] = []
	open var indexes: IndexSet = IndexSet()

	open var selected: [Element] {
		get { return self.indexes.map({ self.items[$0] }) }
		set { self.indexes = IndexSet(newValue.flatMap({ self.items.index(of: $0) })) }
	}

	// MARK: Init

	public init(items: [Element] = []) {
		self.items = items
	}

	open func select(at index: Int) {
		self.indexes.update(with: index)
	}

	open func select(_ item: Element) {
		guard let index = self.items.index(of: item) else { return }
		self.select(at: index)
	}

}
