//
//  RevealAnimator.swift
//  reveal
//
//  Created by Dariel on 16/7/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class RevealAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let animationDuration = 1.0
    // 是否需要push或者pop控制器
    var operation: UINavigationControllerOperation = .Push
    
    weak var storedContext: UIViewControllerContextTransitioning?
    // 设置时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return animationDuration
    }
    
    // 自定义动画的存放地方
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
     
        
        storedContext = transitionContext
        if operation == .Push {
        
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
            
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! DetailViewController
            
            transitionContext.containerView()?.addSubview(toVC.view)
        
        
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = NSValue(CATransform3D: CATransform3DIdentity)
        
            // 添加一个阴影效果
            animation.toValue = NSValue(CATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0)))
            
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
        
            // 同时添加到两个控制器上
            toVC.maskLayer.addAnimation(animation, forKey: nil)
            fromVC.logo.addAnimation(animation, forKey: nil)
        
            // 给目的控制器设置一个渐变效果
            let fadeIn = CABasicAnimation(keyPath: "opacity")
            fadeIn.fromValue = 0.0
            fadeIn.toValue = 1.0
            fadeIn.duration = animationDuration
            toVC.view.layer.addAnimation(fadeIn, forKey: nil)

        }else {
            
            let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
            let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
            
            transitionContext.containerView()?.insertSubview(toView, belowSubview: fromView)
            
            UIView.animateWithDuration(animationDuration, delay: 0.0, options: .CurveEaseIn, animations: {
                fromView.transform = CGAffineTransformMakeScale(0.01, 0.01)
                }, completion: {_ in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
            })
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if let context = storedContext {
            
            context.completeTransition(!context.transitionWasCancelled())
            let fromVc = context.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
            fromVc.logo.removeAllAnimations()
        }
        
        storedContext = nil
    }
    

    
}
