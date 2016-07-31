//
//  RevealAnimator.swift
//  reveal
//
//  Created by Dariel on 16/7/26.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

class RevealAnimator: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    // 是否需要交互
    var interactive = false

    let animationDuration = 2.0
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
            
            animation.toValue = NSValue(CATransform3D:CATransform3DConcat(CATransform3DMakeTranslation(0.0, -10.0, 0.0), CATransform3DMakeScale(150.0, 150.0, 1.0)))
            
            animation.duration = animationDuration
            animation.delegate = self
            animation.fillMode = kCAFillModeForwards
            animation.removedOnCompletion = false
            animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            toVC.maskLayer.addAnimation(animation, forKey: nil)
            fromVC.logo.addAnimation(animation, forKey: nil)
            
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
    
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(recognizer.view!.superview!)
        var progress: CGFloat = abs(translation.x / 200.0)
        progress = min(max(progress, 0.01), 0.99)
        
        switch recognizer.state {
        case .Changed:
            // 更新当前转场动画播放进度
            updateInteractiveTransition(progress)
            
        case .Cancelled, .Ended:
            if operation == .Push { // push
                
                let transitionLayer = storedContext!.containerView()!.layer
                transitionLayer.beginTime = CACurrentMediaTime()
                if progress < 0.5 {
                    completionSpeed = -1.0
                    cancelInteractiveTransition() // 停止转场动画,回到from状态
                } else {
                    completionSpeed = 1.0
                    finishInteractiveTransition() // 完成转场动画,到to状态
                }
            } else { // pop
                
                if progress < 0.5 {
                    cancelInteractiveTransition()
                } else {
                    finishInteractiveTransition()
                }
            }
            
            // 使得返回可交互的转场动画为nil,重置动画
            interactive = false
            
        default:
            break
        }
    }
}
