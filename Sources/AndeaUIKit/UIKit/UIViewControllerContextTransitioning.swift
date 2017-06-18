//
//  UIViewControllerAnimatedTransitioning.swift
//  Pods
//
//  Created by Dani Postigo on 8/31/16.
//
//

import Foundation
import UIKit

extension UIViewControllerContextTransitioning {
    
    public var toView: UIView? {
        return self.view(forKey: UITransitionContextViewKey.to)
    }
    public var toViewController: UIViewController? {
        return self.viewController(forKey: UITransitionContextViewControllerKey.to)
    }
    
    public var toInitialFrame: CGRect {
        return self.initialFrame(for: self.toViewController!)
    }
    
    public var toFinalFrame: CGRect {
        return self.finalFrame(for: self.toViewController!)
    }
    
    public var fromView: UIView? {
        return self.view(forKey: UITransitionContextViewKey.from)
    }
    
    public var fromViewController: UIViewController? {
        return self.viewController(forKey: UITransitionContextViewControllerKey.from)
    }
    
    public var fromInitialFrame: CGRect {
        return self.initialFrame(for: self.fromViewController!)
    }
    
    public var fromFinalFrame: CGRect {
        return self.finalFrame(for: self.fromViewController!)
    }


}


extension UIViewControllerAnimatedTransitioning {
    public func transitionWithContext(_ context: UIViewControllerContextTransitioning, options: UIViewAnimationOptions = .transitionCrossDissolve) {
        context.containerView.addSubview(context.fromView!)
        UIView.transition(from: context.fromView!, to: context.toView!, duration: self.transitionDuration(using: context), options: options, completion: { _ in context.completeTransition(true) })
    }
}

