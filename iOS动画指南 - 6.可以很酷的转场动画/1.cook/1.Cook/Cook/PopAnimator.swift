//
//  PopAnimator.swift
//  Cook
//
//  Created by Dariel on 16/7/25.
//  Copyright © 2016年 Dariel. All rights reserved.
//

import UIKit

// 遵守协议
class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zero
    

    // 动画持续时间
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    // 
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        // 获得容器
        let containerView = transitionContext.containerView()!
        // 获得目标view
        // viewForKey 获取新的和老的控制器的view
        // viewControllerForKey 获取新的和老的控制器
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        
        containerView.addSubview(toView)
        toView.alpha = 0.0
        
        UIView.animateWithDuration(duration, animations: { () -> Void in
            toView.alpha = 1.0
            }) { (_) -> Void in
                // 转场动画完成
            transitionContext.completeTransition(true)
        }
    }
}
