//
// Created by Daniela Postigo on 3/19/18.
//

import Foundation

public protocol SortRepresentableType: Autorepresentable {
    associatedtype Sorted
    var sortHandler: (Sorted, Sorted) -> Bool { get }
}

extension SortRepresentableType {
    public var ascending: SortRepresentable<Self> { return .ascending(self) }
    public var descending: SortRepresentable<Self> { return .descending(self) }
}

public enum SortRepresentable<SortType: SortRepresentableType>: RawRepresentable, ParameterRepresentable {
    case ascending(SortType)
    case descending(SortType)
    
    public init?(rawValue: Int) {
        switch rawValue {
            case let rawValue where rawValue < SortType.count :
                let sortType = SortType(rawValue: rawValue)
                switch sortType {
                    case .none: return nil
                    case .some(let value): self = value.ascending
                }
            default:
                let sortType = SortType(rawValue: rawValue % SortType.count)
                switch sortType {
                    case .none: return nil
                    case .some(let value): self = value.descending
                }
        }
    }
   
    
    public var rawValue: Int {
        switch self {
            case .ascending(let sortType): return sortType.rawValue
            case .descending(let sortType): return SortType.count + sortType.rawValue
        }
    }
    
    
    public var sortValue: SortType {
        switch self {
            case .ascending(let value): return value
            case .descending(let value): return value
        }
    }
    
    public var sortHandler: (SortType.Sorted, SortType.Sorted) -> Bool {
        switch self {
            case .ascending(let sortType): return sortType.sortHandler
            case .descending(let sortType): return { return !sortType.sortHandler($0, $1) }
        }
    }
   
    
    // MARK: Operators
    
    public static prefix func !(a: SortRepresentable<SortType>) -> SortRepresentable<SortType> {
        switch a {
            case .ascending(let sortType): return .descending(sortType)
            case .descending(let sortType): return .ascending(sortType)
        }
    }
    
    // MARK: Utils
    
    public func next(_ sortValue: SortType) -> SortRepresentable<SortType> {
        return sortValue == self.sortValue ? !self : sortValue.ascending
    }
    
    public var isAscending: Bool {
        switch self {
            case .ascending: return true
            case .descending: return false
        }
    }
    
}

extension SortRepresentable: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        return "\(self.sortValue.stringValue) - ASCENDING: \(self.isAscending)"
    }
    
    
}

extension Sequence {
    public func sorted<T>(by sort: SortRepresentable<T>) -> [Element] where T.Sorted == Element {
        return self.sorted(by: sort.sortHandler)
    }
}

