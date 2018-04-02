//
// Created by Daniela Postigo on 4/1/18.
// Copyright (c) 2018 Daniela postigo. All rights reserved.
//

import Foundation

open class ContentViewController<C: UIViewController>: UIViewController, ContainerType {
    public typealias ChildType = C
    
    open var contentViewController: ChildType? {
        didSet { self.update(self.contentViewController, oldValue: oldValue) }
    }
    
    var child: ChildType? {
        return self.contentViewController
    }
    
    // MARK: Init
    
    public init(contentViewController: ChildType?) {
        // self.init()
        super.init(nibName: nil, bundle: nil)
        ({ self.contentViewController = contentViewController })()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
        self.contentViewController.some {
            self.addChildViewController($0)
        }
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    // MARK: View lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.child.some { child in
            child.view.window.none {
                self.addContentViewController(child)
            }
        }
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentViewController?.beginAppearanceTransition(true, animated: animated)
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.contentViewController?.endAppearanceTransition()
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.contentViewController?.beginAppearanceTransition(false, animated: animated)
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.contentViewController?.endAppearanceTransition()
    }
    
    // MARK: Private methods
    
    private func update(_ child: ChildType?, oldValue: ChildType?) {
        self.removeContentViewController(oldValue)
        child.some { self.addChildViewController($0) }
        guard self.isViewLoaded else { return }
        self.addContentViewController(child)
    }
    
    // MARK: Animation State
    
    
    public typealias AnimationHandler = (AnimationState) -> Void
    
    open var animationState: AnimationState?
    
    public enum AnimationState {
        case began(ChildType?, ChildType?)
        case changed(ChildType?, ChildType?)
        case ending(ChildType?, ChildType?)
        case ended
        
        public var oldValue: ChildType? {
            switch self {
                case .began(let oldValue, _): return oldValue
                case .changed(let oldValue, _): return oldValue
                case .ending(let oldValue, _): return oldValue
                case .ended : return nil
            }
        }
        
        public var newValue: ChildType? {
            switch self {
                case .began(_, let newValue): return newValue
                case .changed(_, let newValue): return newValue
                case .ending(_, let newValue): return newValue
                case .ended : return nil
            }
        }
        
        public func beganHandler(handler: () -> Void) {
            self.beganHandler(handler: { _ in handler() })
        }
        
        public func beganHandler(handler: (AnimationState) -> Void) {
            if case .began = self { handler(self) }
        }
    
        public func endingHandler(handler: () -> Void) {
            self.endingHandler(handler: { _ in handler() })
        }
    
        public func endingHandler(handler: (AnimationState) -> Void) {
            if case .ending = self { handler(self) }
        }
    
        public func endedHandler(handler: () -> Void) {
            if case .ended = self { handler() }
        }
    }
    
    // MARK: Animation methods
    
    open func setContentViewController(_ newValue: ChildType?, animated: Bool = true, completionHandler: Completion? = nil) {
        self.setContentViewController(newValue, animated: animated) {
            $0.endedHandler { completionHandler?() }
        }
    }
    
    open func setContentViewController(_ newValue: ChildType?, animated: Bool = true, animationHandler: AnimationHandler? = nil) {
        switch animated {
            case false:
                let oldValue = self.contentViewController
                self.setAnimationState(.began(oldValue, newValue), handler: animationHandler)
                self.contentViewController = newValue
                self.setAnimationState(.ended, handler: animationHandler)
            
            case true: self.animateContentViewController(newValue, oldValue: self.contentViewController, handler: animationHandler)
        }
    }
    
    
    // MARK: Animation methods / private
    
    private func animateContentViewController(_ newValue: ChildType?, oldValue: ChildType?, handler: AnimationHandler? = nil) {
        switch (oldValue, newValue) {
            case (.none, .none):
                self.setAnimationState(.began(oldValue, newValue), handler: handler)
                self.setAnimationState(.ended, handler: handler)
            
            default:
                self.setAnimationState(.began(oldValue, newValue), handler: handler)
                
                let animations: () -> Void = {
                    oldValue?.view.removeFromSuperview()
                    self.setAnimationState(.changed(oldValue, newValue), handler: handler)
                }
                
                oldValue?.willMove(toParentViewController: nil)
                newValue.some {
                    self.addChildViewController($0)
                    self.view.embed($0.view, from: self.view.safeAreaLayoutGuide)
                }
                
                UIView.transition(
                    with: self.view,
                    duration: 0.4,
                    options: .transitionCrossDissolve,
                    animations: animations,
                    completion: { _ in
                        self.setAnimationState(.ending(oldValue, newValue), handler: handler)
                        oldValue?.removeFromParentViewController()
                        newValue?.didMove(toParentViewController: self)
                        self.contentViewController = newValue
                        self.setAnimationState(.ended, handler: handler)
                    })
        }
        
    }
    
    private func setAnimationState(_ state: AnimationState, handler: AnimationHandler? = nil) {
        self.animationState = { if case .ended = state { return nil }; return state }()
        handler?(state)
    }
}

