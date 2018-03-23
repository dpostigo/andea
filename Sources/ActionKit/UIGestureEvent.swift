//
// Created by Daniela Postigo on 3/21/18.
//

import Foundation

public struct UIGestureEvent {
    public let kind: UIGestureRecognizerKind
    public var state: UIGestureRecognizerState = .possible
    public var duration: TimeInterval = 0
    public var locations: [UIGestureRecognizerState: [CGPoint]] = [:]
    
    private var start: Date = Date()
    
    // MARK: Init
    
    init(kind: UIGestureRecognizerKind) {
        self.kind = kind
        self.locations = UIGestureRecognizerState.all.dictionary { _ in [CGPoint]() }
    }
    
    public subscript( _ state: UIGestureRecognizerState) -> [CGPoint] {
        get { return self.locations[state]! }
        set { self.locations[state] = newValue }
    }
    
    fileprivate mutating func transform(_ gesture: UIGestureRecognizer) -> UIGestureEvent {
        self.state = gesture.state
        self.dateHandler(gesture)
        self.locationHandler(gesture)
        return self
    }
    
    private mutating func locationHandler(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
            case .changed: self[.changed] += gesture.location(in: gesture.view)
            default: self[gesture.state] = [gesture.location(in: gesture.view)]
        }
    }
    
    private mutating func dateHandler(_ gesture: UIGestureRecognizer) {
        switch gesture.state {
            case .began: self.start = Date()
            case .ended: self.duration = Date().timeIntervalSince(self.start)
            default: break
        }
    }
}

extension UIGestureEvent {
    
    public var points: [CGPoint] { return UIGestureRecognizerState.all.flatMap { self[$0] }}
    public var locationStart: CGPoint? { return self.locations[.began]?.first }
    public var locationEnd: CGPoint? { return self.locations[.ended]?.first }
    
}

extension UIView {
    
    public func addGestureEvent(_ kind: UIGestureRecognizerKind, state: UIGestureRecognizerState, gestureHandler: @escaping (UIGestureEvent) -> Void) {
        self.addGestureEvent(kind) { if $0.state == state { gestureHandler($1) } }
    }
    
    public func addGestureEvent(_ kind: UIGestureRecognizerKind, gestureHandler: @escaping (UIGestureEvent) -> Void) {
        self.addGestureEvent(kind) { gesture, event in gestureHandler(event) }
    }
    
    public func addGestureEvent(_ kind: UIGestureRecognizerKind, gestureHandler: @escaping (UIGestureRecognizer, UIGestureEvent) -> Void) {
        var event = UIGestureEvent(kind: kind)
        
        self.addGestureRecognizer(kind) { gesture in
            event = event.transform(gesture)
            gestureHandler(gesture, event)
            if case .ended = gesture.state { event = UIGestureEvent(kind: kind) }
            
        }
    }
}


extension UIGestureRecognizerState {

}
